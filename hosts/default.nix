{ self, inputs, l, ... }:

{
  flake.nixosConfigurations = let
    inherit (l) nixosSystem;

    system = "${self}/system";
    users = "${self}/users";
    home = "${self}/home";

    specialArgs = {
      inherit inputs;
      inherit l;
      inherit home;
    };
  in {

    # Hydrogen is my personal laptop
    Hydrogen = nixosSystem {
      inherit specialArgs;
      modules = [
        ./Hydrogen
        "${system}"
        "${system}/boot/systemd.nix"
        "${system}/fs/zfs-persist.nix"

        "${system}/networking/wifi.nix"

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

        "${users}"
        "${users}/home.nix"
        "${users}/padraic.nix"
      ];
    };
  };
}
