{ config, ... }:
let
  remoteForwards = [{
    host.address = config.home.sessionVariables.SSH_AUTH_SOCK;
    bind.address = config.home.sessionVariables.SSH_AUTH_SOCK;
  }];
in {
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
  };
}
