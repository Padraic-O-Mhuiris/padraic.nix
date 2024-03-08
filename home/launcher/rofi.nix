{ config, lib, ... }:

{
  programs.rofi.enable = true;

  home.sessionVariables."LAUNCHER" =
    "${lib.getExe config.programs.rofi.finalPackage} -show drun";
}
