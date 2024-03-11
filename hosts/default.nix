{ self, inputs, l, ... }:

let
  inherit (l) nixosSystem;

  system = "${self}/system";
  users = "${self}/users";
  home = "${self}/home";

  vm' = "${self}/vm";

  specialArgs = {
    inherit inputs;
    inherit l;
    inherit home;
  };

in {
  flake.nixosConfigurations = {
    # Hydrogen is my personal laptop
    Hydrogen = nixosSystem {
      inherit specialArgs;
      modules = [
        ./Hydrogen
        "${system}"
        "${system}/boot/systemd.nix"
        "${system}/fs/zfs-persist.nix"

        "${system}/display/xserver.nix"
        "${system}/hardware/keyboard.nix"
        "${system}/hardware/audio.nix"

        "${users}"
        "${users}/home.nix"
        "${users}/padraic.nix"
      ];
    };

    # Oxygen is my personal desktop pc
    Oxygen = nixosSystem {
      inherit specialArgs;
      modules = [
        ./Oxygen
        "${system}"
        "${system}/boot/systemd.nix"
        "${system}/fs/zfs-persist.nix"

        "${system}/display/xserver.nix"
        "${system}/hardware/keyboard.nix"
        "${system}/hardware/audio.nix"

        "${users}"
        "${users}/home.nix"
        "${users}/padraic.nix"
      ];
    };
  };

  perSystem = { inputs', pkgs, ... }: {
    packages = {
      inherit ((nixosSystem {

        inherit specialArgs;
        modules = [
          "${system}"
          "${system}/display/xserver.nix"
          "${system}/hardware/keyboard.nix"

          { services.xserver.displayManager.autoLogin.user = "padraic"; }
          "${vm'}"

          "${users}"
          "${users}/home.nix"
          "${users}/padraic.nix"
        ];
      }).config.system.build)
        vm;

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

        ${l.getExe inputs'.nixos-anywhere.packages.default} \
        --disk-encryption-keys /tmp/secret.key <(echo -n $(${
          l.getExe pkgs.pass
        } show os/hosts/Oxygen/disk)) \
        --extra-files "$temp" \
        --no-reboot \
        --print-build-logs \
        --debug \
        --flake ${self}#Oxygen root@192.168.0.214
      '';
    };
  };
}
