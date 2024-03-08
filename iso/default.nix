# This configuration produces a package "iso" which is an iso image of a base nix configuration image.
# Used in order to bootstrap nixos installations

{ inputs, l, ... }:

let
  inherit (inputs) nixpkgs;

  iso = l.nixosSystem {
    specialArgs = {
      inherit inputs;
      inherit l;
    };
    modules = [
      "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
      "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"

      ({ pkgs, l, ... }: {

        nixpkgs.hostPlatform = l.mkDefault "x86_64-linux";
        nixpkgs.config.allowUnfree = true;

        nix.settings.experimental-features = [ "nix-command" "flakes" ];
        nix.extraOptions = "experimental-features = nix-command flakes";

        networking = {
          hostName = "NIXOS-USB";

          wireless.enable = true;
          wireless.networks.VM9598311.psk = "cjDpkp9F5sdf";
        };

        services.openssh.enable = true;

        environment.systemPackages = with pkgs; [ vim git ];

        users.extraUsers.root.openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEFlro/QUDlDpaA1AQxdWIqBg9HSFJf9Cb7CPdsh0JN7"
        ];

        systemd.services.sshd.wantedBy =
          pkgs.lib.mkForce [ "multi-user.target" ];

        system.stateVersion = l.mkDefault "24.05";
      })
    ];
  };
in {

  perSystem = { config, self', inputs', pkgs, system, ... }: {
    packages.iso = iso.config.system.build.isoImage;
  };
}
