{
  l,
  pkgs,
  nixosConfig,
  ...
}:
{
  xsession = {
    enable = true;
    scriptPath = ".hm-xsession";
    profileExtra =
      if nixosConfig.services.autorandr.enable then
        "${l.getExe' pkgs.autorandr "autorandr"} -l ${nixosConfig.services.autorandr.defaultTarget}"
      else
        "";
  };
}
