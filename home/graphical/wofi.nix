{ config, l, ... }: {
  programs.wofi.enable = true;
  home.sessionVariables."LAUNCHER" =
    "${l.getBin config.programs.wofi.package}/bin/wofi --show drun -I";
}
