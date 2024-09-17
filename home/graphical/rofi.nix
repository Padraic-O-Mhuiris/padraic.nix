{ config, l, ... }: {
  programs.rofi.enable = true;

  home.sessionVariables."LAUNCHER" =
    "${l.getExe config.programs.rofi.finalPackage} -show drun";
}
