{ config, ... }:

{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      update_check = false;
      sync_address = "https://api.atuin.sh"; # TODO Change
      sync_frequency = "15m";
      dialect = "uk";
      key_path = config.sops.secrets.atuin_key.path;
    };
  };

  sops.secrets.atuin_key = { };
}
