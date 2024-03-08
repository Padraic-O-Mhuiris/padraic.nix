# This is the root configuration file for all configuration which will be
# shared amongst all hosts.

{ pkgs, l, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./boot
    ./nix
    ./networking
  ];

  environment.systemPackages = with pkgs; [ git coreutils vim ];

  time.timeZone = l.mkDefault "Europe/Dublin";
  system.stateVersion = l.mkDefault "24.05";
}
