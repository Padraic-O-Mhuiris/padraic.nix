{
  # NOTE Screen name ID changes between using nvidia prime or offload
  services.autorandr = {
    enable = true;
    defaultTarget = "main";
    profiles.main = {
      fingerprint = {
        "eDP-1" = "00ffffffffffff004d101615000000000a1f0104b52215780ac420af5031bd240b50540000000101010101010101010101010101010172e700a0f06045903020360050d21000001828b900a0f06045903020360050d210000018000000fe004a4e4a5939804c513135365231000000000002410332011200000b010a2020013a02030f00e3058000e606050160602800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aa";
      };
      config = {
        "eDP-1" = {
          enable = true;
          dpi = 160;
          primary = true;
          position = "0x0";
          mode = "3840x2400";
          rate = "59.99";
        };
      };
    };
  };

  # Adding these settings here for easier lookup
  environment.variables = {
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  };
}
