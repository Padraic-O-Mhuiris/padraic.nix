{ config, pkgs, ... }:
{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      daemon.enabled = true;
      update_check = false;
      sync_address = "https://api.atuin.sh"; # TODO Change
      sync_frequency = "15m";
      sync.records = true;
      dialect = "uk";
      key_path = config.sops.secrets.atuin_key.path;
    };
  };

  systemd.user.services.atuind = {
    Unit = {
      Description = "Initialises the atuin daemon";
      After = "network.target";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${pkgs.atuin}/bin/atuin daemon";
    };
  };

  sops.secrets.atuin_key = { };
}
