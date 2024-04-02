{ config, l, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window.padding = {
        x = 10;
        y = 10;
      };
    };
  };

  home.sessionVariables = let
    terminalClass = "TERMINAL_ALACRITTY";
    terminalPkg = pkgs.writeShellScriptBin "terminal" ''
      ${
        l.getBin config.programs.alacritty.package
      }/bin/alacritty --class ${terminalClass} -e ${l.getBin pkgs.tmux}/bin/tmux
    '';
  in {
    TERMINAL = "${l.getBin terminalPkg}/bin/terminal";
    TERMINAL_CLASS = terminalClass;
    # https://alacritty.org/config-alacritty.html ENV
    WINIT_X11_SCALE_FACTOR = 1;
  };
}
