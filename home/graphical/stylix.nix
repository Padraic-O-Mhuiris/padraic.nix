{ config, pkgs, ... }:

let
  serif = {
    package = pkgs.iosevka-comfy.comfy-motion-duo;
    name = "Iosevka Comfy Motion Duo";
  };
  sansSerif = {
    package = pkgs.iosevka-comfy.comfy-duo;
    name = "Iosevka Comfy Duo";
  };
  monospace = {
    package = pkgs.iosevka-comfy.comfy-fixed;
    name = "Iosevka Comfy Fixed";
  };
  emoji = monospace;
in {

  home = {
    sessionVariables = {
      GDK_SCALE = "2";
      GDK_DPI_SCALE = "0.5";
    };
    # Necessary for gtk
    packages = [ pkgs.dconf ];
  };
  stylix = {
    targets = {
      gtk.enable = true;
      gnome.enable = true;
      alacritty.enable = true;
      vim.enable = true;
      i3.enable = true;
      xresources.enable = true;
    };
    fonts = {
      inherit serif sansSerif monospace emoji;
      sizes = {
        applications = 11;
        desktop = 10;
        popups = 22;
        terminal = 18;
      };
    };
  };
}
