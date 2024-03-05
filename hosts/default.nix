{ self, inputs, l, ... }:

{
  flake.nixosConfigurations = let
    inherit (l) nixosSystem;

    root = "${self}/system";

    specialArgs = {
      inherit inputs;
      inherit l;
    };
  in {

    # Hydrogen is my personal laptop
    Hydrogen = nixosSystem {
      inherit specialArgs;
      modules = [
        ./Hydrogen
        "${root}"
        "${root}/boot/systemd.nix"
        "${root}/fs/zfs-persist.nix"
      ];
    };

    # Oxygen is my personal desktop pc
    Oxygen = nixosSystem {
      inherit specialArgs;
      modules = [
        ./Oxygen
        "${root}"
        "${root}/boot/systemd.nix"
        "${root}/fs/zfs-persist.nix"
      ];
    };
  };
}
