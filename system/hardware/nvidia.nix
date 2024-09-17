{ config, ... }: {
  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      prime.sync.enable = true;
      forceFullCompositionPipeline = true;
    };
    graphics.enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
