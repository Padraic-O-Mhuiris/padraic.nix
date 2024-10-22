{ config, ... }:
let
  remoteForwards = [
    {
      bind.address = "/run/user/1000/gnupg/d.u7ukbdjqgf6bp5z34ihyfrkj/S.gpg-agent.ssh";
      host.address = "/run/user/1000/gnupg/d.u7ukbdjqgf6bp5z34ihyfrkj/S.gpg-agent.extra";
    }
  ];
in
{
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    # Build this programatically given the config elsewhere
    matchBlocks = {
      "Oxygen" = {
        host = "oxygen.tail684cf.ts.net";
        user = config.home.username;
        inherit remoteForwards;
      };
      "Hydrogen" = {
        host = "hydrogen.tail684cf.ts.net";
        user = config.home.username;
        inherit remoteForwards;
      };
    };

    extraConfig = ''
      StreamLocalBindUnlink yes
    '';
  };
}
