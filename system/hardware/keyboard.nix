{ l, config, ... }:

l.mkIf config.services.xserver.enable {
  services.xserver = {
    xkb = {
      options = "ctrl:swapcaps";
      layout = "gb";
    };
  };

  console.useXkbConfig = true;
}
