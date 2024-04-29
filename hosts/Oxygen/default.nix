_:

{
  imports = [ ./boot.nix ./hardware.nix ./monitors.nix ];

  # TODO Make into a regular import
  disko.devices.disk = import ./disk.nix;

  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "Oxygen";
  networking.hostId = "83b0a257";
}
