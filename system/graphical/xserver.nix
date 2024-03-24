# Importing this modules offloads display manager configuration to the home config

{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    # TODO Add an assertion such that a home-manager xsession is defined if this configuration is included
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
