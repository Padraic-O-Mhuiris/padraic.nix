{ config, lib, pkgs, ... }:

{
  networking.hostName = "Oxygen";
  nixpkgs.hostPlatform = "x86_64-linux";
}
