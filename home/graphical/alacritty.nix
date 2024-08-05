{ config, l, ... }:

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

  home.sessionVariables = {
    TERMINAL = "${l.getBin config.programs.alacritty.package}/bin/alacritty";
    # https://alacritty.org/config-alacritty.html ENV
    WINIT_X11_SCALE_FACTOR = 1;
  };
}
