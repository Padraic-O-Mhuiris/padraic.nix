_:

{
  imports = [ ./boot.nix ];

  disko.devices.disk = import ./disk.nix;

  networking.hostName = "Oxygen";
  networking.hostId = "83b0a257";
}
