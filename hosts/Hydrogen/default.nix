_:

{
  imports = [ ./boot.nix ./hardware.nix ./monitors.nix ./disk.nix ];

  environment.sessionVariables = {
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1.75";
  };

  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "Hydrogen";
  networking.hostId = "3f90d23a";
}
