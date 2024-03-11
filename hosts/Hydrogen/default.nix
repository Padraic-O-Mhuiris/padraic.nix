_:

{
  imports = [ ./boot.nix ];

  disko.devices.disk = import ./disk.nix;

  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "Hydrogen";
  networking.hostId = "3f90d23a";

}
