{
  config,
  nixosConfig,
  l,
  pkgs,
  ...
}:
let
  modifier = "Mod4";

  terminalScreenRatio = "95%x95%";

in
{
  imports = [
    ../xsession.nix
    ../rofi.nix
    ../alacritty.nix
    ../fonts.nix
    ../stylix.nix
    ../dunst.nix
    ./i3toggle.nix
  ];

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      inherit modifier;
      terminal = config.home.sessionVariables.TERMINAL;
      menu = config.home.sessionVariables.LAUNCHER;
      keybindings = l.mkOptionDefault {
        "${modifier}+Shift+q" = null;
        "${modifier}+Return" = "exec ${config.xsession.windowManager.i3.config.terminal}";
        "${modifier}+q" = "kill";

        "${modifier}+x" = ''
          exec --no-startup-id "i3toggle -t -acc -d ${terminalScreenRatio} -- ${config.home.sessionVariables.TERMINAL} -e ${l.getExe pkgs.tmux}"
        '';
      };
      defaultWorkspace = "workspace number 1";
      gaps = {
        inner = 10;
        outer = 5;
      };
      floating = {
        titlebar = false;
        border = 1;
      };
      window = {
        titlebar = false;
        border = 1;
      };
      # bars = [ ];
    };
  };
}
