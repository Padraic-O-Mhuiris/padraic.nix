{ config, osConfig, ... }:

{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      # sync_address = #TODO;
      sync_frequency = "15m";
      dialect = "uk";
      key_path = osConfig.sops.secrets.atuin_key.path;
    };
  };

  sops.secrets.atuin_key = { };
}
