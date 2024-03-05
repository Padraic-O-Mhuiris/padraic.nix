{ self, inputs, l, config, ... }:

{
  flake = {
    nixosConfigurations = let
      inherit (l) nixosSystem;
      specialArgs = { };
    in {
      Hydrogen = nixosSystem {
        inherit specialArgs;
        modules = [ ./Hydrogen ];
      };

      Oxygen = nixosSystem {
        inherit specialArgs;
        modules = [ ./Oxygen ];
      };
    };
  };
}
