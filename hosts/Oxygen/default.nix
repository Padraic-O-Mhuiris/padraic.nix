_:

{
  imports = [ ./boot.nix ./hardware.nix ];

  disko.devices.disk = import ./disk.nix;

  networking.hostName = "Oxygen";
  networking.hostId = "83b0a257";
}
