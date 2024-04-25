{ config, ... }:

{
  imports = [ ./ssh.nix ];

  networking = {
    nameservers = [ "1.1.1.1" "8.8.8.8" "9.9.9.9" "100.100.100.100" ];
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 ];
      allowedUDPPorts = [ ];
      checkReversePath = "loose";
    };
    hosts = { "127.0.0.1" = [ config.networking.hostName ]; };
  };
}
