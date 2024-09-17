{ config, ... }: {
  # TODO Add systemd one-shot to download repo if it doesn't exist

  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.password-store";
      PASSWORD_STORE_KEY = config.programs.git.signing.key;
    };
  };
}
