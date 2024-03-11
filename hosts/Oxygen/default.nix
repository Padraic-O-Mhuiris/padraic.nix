_:

{
  imports = [ ./boot.nix ./hardware.nix ./monitors.nix ];

  disko.devices.disk = import ./disk.nix;

  services.xserver.displayManager.autoLogin.user = "padraic";
  services.xserver.xkb.layout = "us";

  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "Oxygen";
  networking.hostId = "83b0a257";
}
