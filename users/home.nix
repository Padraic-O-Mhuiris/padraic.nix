# This configuration imports and defines the system-level configuration for the
# home-manager nixosModule. User-specific home-manager configuration is defined
# generally under //home or in a user specific file //user/<USER>

{ self, inputs, l, config, ... }:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [ inputs.sops.homeManagerModules.sops ];
    extraSpecialArgs = {
      inherit inputs self;
      l = l.extend (_: prev: prev // inputs.home-manager.lib);
      inherit (config.system) stateVersion;
    };
  };
}
