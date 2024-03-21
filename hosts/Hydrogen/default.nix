_:

{
  imports = [ ./boot.nix ./hardware.nix ./monitors.nix ];

  disko.devices.disk = import ./disk.nix;

  environment.sessionVariables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
  };

  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "Hydrogen";
  networking.hostId = "3f90d23a";
}
