{ config, ... }:
{
  programs.ssh = {
    enable = true;
    # Build this programatically given the config elsewhere
    matchBlocks = {
      "Oxygen" = {
        host = "oxygen.tail684cf.ts.net";
        user = config.home.username;
      };
      "Hydrogen" = {
        host = "hydrogen.tail684cf.ts.net";
        user = config.home.username;
      };
    };
  };
}
