_:

{
  imports = [ ./boot.nix ./hardware.nix ./disk.nix ];

  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "Hydrogen";
  networking.hostId = "3f90d23a";
}
