{
  config,
  lib,
  pkgs,
  ...
}:
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    iosevka
    iosevka-comfy.comfy-motion-duo
    iosevka-comfy.comfy-fixed
    iosevka-comfy.comfy-duo
    corefonts
    dejavu_fonts
    liberation_ttf
    roboto
    fira-code
    jetbrains-mono
    siji
    font-awesome
    cascadia-code
    nerdfonts
  ];
}
