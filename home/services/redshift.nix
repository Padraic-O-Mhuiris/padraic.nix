{ nixosConfig, ... }: {
  services.redshift = {
    inherit (nixosConfig.location) latitude longitude;
    enable = true;
    provider = "manual";
    tray = true;
    temperature = {
      day = 7000;
      night = 2500;
    };
  };
}
