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
    cursor.size =
      if nixosConfig.networking.hostName == "Oxygen" then 24 else 48;
    fonts = {
      inherit serif sansSerif monospace emoji;
      sizes = {
        applications =
          if nixosConfig.networking.hostName == "Oxygen" then 12 else 12;
        desktop =
          if nixosConfig.networking.hostName == "Oxygen" then 10 else 10;
        popups = 22;
        terminal =
          if nixosConfig.networking.hostName == "Oxygen" then 12 else 18;
      };
    };
  };
}
