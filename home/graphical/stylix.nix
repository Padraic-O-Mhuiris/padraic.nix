{ config, nixosConfig, pkgs, ... }:

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

  home.packages = [ pkgs.dconf ];
  stylix = {
    targets = {
      btop.enable = true;
      rofi.enable = true;
      tmux.enable = true;
      gtk.enable = true;
      gnome.enable = true;
      alacritty.enable = true;
      vim.enable = true;
      i3.enable = true;
      xresources.enable = true;
    };
    cursor.size = 24;
    fonts = {
      inherit serif sansSerif monospace emoji;
      sizes = {
        applications = 11;
        desktop = 10;
        popups = 22;
        terminal =
          if nixosConfig.networking.hostName == "Oxygen" then 12 else 18;
      };
    };
  };
}
