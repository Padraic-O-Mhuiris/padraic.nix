{ stateVersion, pkgs, config, ... }: {

  imports = [ ./programs ];

  home = {
    packages = with pkgs; [
      htop
      # TODO Move this somewhere
      gnome.nautilus
    ];

    enableNixpkgsReleaseCheck = true;
    inherit stateVersion;
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "${config.home.homeDirectory}/desktop";
      download = "${config.home.homeDirectory}/downloads";
      extraConfig = { XDG_CODE_DIR = "${config.home.homeDirectory}/code"; };
      music = "${config.home.homeDirectory}/music";
    };
  };

  systemd.user.startServices = "sd-switch";
}
