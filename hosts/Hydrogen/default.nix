{ config, lib, pkgs, ... }:

{
  networking.hostName = "Hydrogen";
  nixpkgs.hostPlatform = "x86_64-linux";
}
