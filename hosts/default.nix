{ self, inputs, l, ... }:

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
  };

in {
  flake.nixosConfigurations = {
    # Hydrogen is my personal laptop
    Hydrogen = nixosSystem {
      inherit specialArgs;
      modules = [
        {
          nixpkgs.overlays = [
            inputs.nur.overlay
            inputs.emacs.overlay
            inputs.nil.overlays.default
          ];
        }
        ./Hydrogen
        "${system}"
        "${system}/boot/systemd.nix"
        "${system}/fs/zfs-persist.nix"

        "${system}/display/xserver.nix"

        "${system}/hardware/keyboard.nix"
        "${system}/hardware/audio.nix"
        "${system}/hardware/bluetooth.nix"
        "${system}/hardware/backlight.nix"
        "${system}/hardware/yubikey.nix"

        "${users}"
        "${users}/home.nix"
        "${users}/padraic.nix"

        "${secrets}"
      ];
    };

    Oxygen = nixosSystem {
      # Oxygen is my personal desktop pc
      inherit specialArgs;
      modules = [
        {
          nixpkgs.overlays = [
            inputs.nur.overlay
            inputs.emacs.overlay
            inputs.nil.overlays.default
          ];
        }
        ./Oxygen
        "${system}"
        "${system}/boot/systemd.nix"
        "${system}/fs/zfs-persist.nix"

        "${system}/display/xserver.nix"
        "${system}/hardware/keyboard.nix"
        "${system}/hardware/audio.nix"
        "${system}/hardware/bluetooth.nix"
        "${system}/hardware/yubikey.nix"

        "${users}"
        "${users}/home.nix"
        "${users}/padraic.nix"

        "${secrets}"
      ];
    };
  };

  perSystem = { inputs', pkgs, ... }: {
    packages = {

      # NOTE nix run .\#vm -- --display gtk,full-screen=on,grab-on-hover=on -smp cpus=8 -m size=8192
      #
      # TODO Figure out how to run the vm with proper screen resolution
      # TODO Add qemu flags to command
      inherit ((nixosSystem {
        inherit specialArgs;
        modules = [
          {
            nixpkgs.overlays = [
              inputs.nur.overlay
              inputs.emacs.overlay
              inputs.nil.overlays.default
            ];
          }

          "${system}"
          "${system}/display/xserver.nix"
          "${system}/hardware/keyboard.nix"

          "${vm'}"

          "${users}"
          "${users}/home.nix"
          "${users}/padraic.nix"
        ];
      }).config.system.build)
        vm;

      # TODO Add user ssh bootstrapping so that user ssh private key is available on initial setup
      deployOxygen = pkgs.writeShellScriptBin "deployOxygen" ''
        temp=$(mktemp -d)

        cleanup() {
          rm -rf "$temp"
        }
        trap cleanup EXIT

        install -d -m755 "$temp/persist/etc/ssh"

        pass os/hosts/Oxygen/ssh_host_ed25519_key > "$temp/persist/etc/ssh/ssh_host_ed25519_key"
        pass os/hosts/Oxygen/ssh_host_ed25519_key.pub > "$temp/persist/etc/ssh/ssh_host_ed25519_key.pub"

        chmod 600 "$temp/persist/etc/ssh/ssh_host_ed25519_key"
        chmod 644 "$temp/persist/etc/ssh/ssh_host_ed25519_key.pub"

        ${inputs'.nixos-anywhere.packages.default}/bin/nixos-anywhere \
        --disk-encryption-keys /tmp/secret.key <(echo -n $(${
          l.getExe pkgs.pass
        } show os/hosts/Oxygen/disk)) \
        --extra-files "$temp" \
        --no-reboot \
        --print-build-logs \
        --debug \
        --flake ${self}#Oxygen root@192.168.0.214
      '';

      # TODO Make more general
      editHostSecrets = pkgs.writeShellScriptBin "editHostSecrets" ''
        EDITOR=${pkgs.vim}/bin/vim \
        SOPS_AGE_KEY=$(${pkgs.ssh-to-age}/bin/ssh-to-age -private-key <<< $(${pkgs.pass}/bin/pass show os/users/padraic/id_ed25519)) \
        ${pkgs.sops}/bin/sops $HOME/code/nix/nixos-configuration/hosts/Oxygen/secrets.yaml
      '';

    };
  };
}
