_:

{
  imports = [ ./boot.nix ];

  disko.devices.disk = import ./disk.nix;

  networking.hostName = "Hydrogen";
  networking.hostId = "3f90d23a";
}
