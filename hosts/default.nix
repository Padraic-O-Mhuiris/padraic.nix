{
  self,
  inputs,
  l,
  ...
}:
let
  inherit (l) nixosSystem;

  system = "${self}/system";
  users = "${self}/users";
  hosts = "${self}/hosts";
  home = "${self}/home";
  secrets = "${self}/secrets";

  vm' = "${self}/vm";

  specialArgs = {
    inherit inputs;
    inherit l;
    inherit home;
    inherit hosts;
    inherit self;
  };

  common = [
    {
      nixpkgs.overlays = [
        inputs.nur.overlay
        inputs.emacs.overlay
        inputs.nil.overlays.default
      ];
    }

    "${system}"
    "${system}/boot/systemd.nix"
    "${system}/fs/zfs-persist.nix"

    "${system}/graphical/stylix.nix"

    "${system}/hardware/nvidia.nix"
    "${system}/hardware/keyboard.nix"
    "${system}/hardware/audio.nix"
    "${system}/hardware/bluetooth.nix"
    "${system}/hardware/yubikey.nix"
    "${system}/hardware/ledger.nix"
    "${system}/hardware/external-disks.nix"

    "${system}/networking/tailscale.nix"

    "${system}/virtualisation/docker.nix"

    "${users}"
    "${users}/padraic.nix"

    "${secrets}"
  ];
in
{
  flake.nixosConfigurations = {
    # Hydrogen is my personal laptop
    Hydrogen = nixosSystem {
      inherit specialArgs;
      modules = [
        ./Hydrogen

        "${system}/hardware/backlight.nix"
        "${system}/graphical/xserver.nix"
      ] ++ common;
    };

    Oxygen = nixosSystem {
      # Oxygen is my personal desktop pc
      inherit specialArgs;
      modules = [
        ./Oxygen

        "${system}/graphical/xserver.nix"
        "${system}/programs/steam.nix"
      ] ++ common;
    };
  };

  perSystem =
    { inputs', pkgs, ... }:
    {
      packages = {
        # NOTE nix run .\#vm -- --display gtk,full-screen=on,grab-on-hover=on -smp cpus=8 -m size=8192
        #
        # TODO Figure out how to run the vm with proper screen resolution
        # TODO Add qemu flags to command
        # inherit ((nixosSystem {
        #   inherit specialArgs;
        #   modules = [
        #     {
        #       nixpkgs.overlays = [
        #         inputs.nur.overlay
        #         inputs.emacs.overlay
        #         inputs.nil.overlays.default
        #       ];
        #     }

        #     "${system}"

        #     "${system}/graphical/xserver.nix"
        #     "${system}/hardware/keyboard.nix"

        #     "${vm'}"

        #     "${users}"
        #     "${users}/padraic.nix"
        #   ];
        # }).config.system.build)
        #   vm;

        # TODO Add user ssh bootstrapping so that user ssh private key is available on initial setup
        # TODO Provision user ssh key with correct permissions
        #
        # `nix run .#deploy -- <OS_NAME> <MACHINE_IP>`
        # deploy = pkgs.writeShellScriptBin "deploy" ''
        #   host=$1
        #   ip=$2
        #   temp=$(mktemp -d)

        #   cleanup() {
        #     rm -rf "$temp"
        #   }
        #   trap cleanup EXIT

        #   install -d -m755 "$temp/persist/etc/ssh"
        #   install -d -m755 "$temp/home/padraic/.ssh"

        #   pass "os/hosts/$host/ssh_host_ed25519_key" > "$temp/persist/etc/ssh/ssh_host_ed25519_key"
        #   pass "os/hosts/$host/ssh_host_ed25519_key.pub" > "$temp/persist/etc/ssh/ssh_host_ed25519_key.pub"

        #   pass "os/users/padraic/id_ed25519" > "$temp/home/padraic/.ssh/id_ed25519"
        #   pass "os/users/padraic/id_ed25519.pub" > "$temp/home/padraic/.ssh/id_ed25519.pub"

        #   chmod 600 "$temp/persist/etc/ssh/ssh_host_ed25519_key"
        #   chmod 644 "$temp/persist/etc/ssh/ssh_host_ed25519_key.pub"

        #   chmod 700 "$temp/home/padraic/.ssh/id_ed25519"
        #   chmod 644 "$temp/home/padraic/.ssh/id_ed25519.pub"

        #   ${inputs'.nixos-anywhere.packages.default}/bin/nixos-anywhere \
        #   --disk-encryption-keys /tmp/secret.key <(echo -n $(${
        #     l.getExe pkgs.pass
        #   } show "os/hosts/$host/disk")) \
        #   --extra-files "$temp" \
        #   --no-reboot \
        #   --print-build-logs \
        #   --debug \
        #   --flake "${self}#$host" "root@$ip"
        # '';
      };
    };
}
