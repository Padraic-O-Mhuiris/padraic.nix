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
  stylix = {
    targets = {
      gtk.enable = true;
      gnome.enable = true;
      alacritty.enable = true;
    };
    fonts = { inherit serif sansSerif monospace emoji; };
  };
}
