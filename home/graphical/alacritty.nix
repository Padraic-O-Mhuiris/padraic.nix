{ config, l, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window.padding = {
        x = 10;
        y = 10;
      };
      scale_with_dpi = false;
    };
  };

  home.sessionVariables = {
    TERMINAL = "${l.getExe' config.programs.alacritty.package "alacritty"}";
  };
}
