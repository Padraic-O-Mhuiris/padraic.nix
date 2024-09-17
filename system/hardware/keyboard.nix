{ l, config, ... }:
l.mkIf config.services.xserver.enable {
  services.xserver = {
    xkb = {
      options = "ctrl:swapcaps";
      layout = l.mkDefault "gb";
    };
  };

  console.useXkbConfig = true;
}
