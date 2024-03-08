# Importing this modules offloads display manager configuration to the home config

{ pkgs, ... }:

{
  services.xserver = {
    enable = true;

    desktopManager.session = [{
      name = "home-manager";
      start = ''
        ${pkgs.runtimeShell} $HOME/.hm-xsession &
        waitPID=$!
      '';
    }];
    displayManager.defaultSession = "home-manager";
  };
}
