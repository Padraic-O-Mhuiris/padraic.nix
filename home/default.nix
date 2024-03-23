{ stateVersion, pkgs, config, nixosConfig, ... }: {

  imports = [ ./programs ];

  home = {
    packages = with pkgs; [
      htop
      # TODO Move this somewhere
      gnome.nautilus
    ];

    enableNixpkgsReleaseCheck = true;
    inherit stateVersion;

    shellAliases = {
      # TODO Create default filesystem location for this nixos repository
      "nr" =
        "sudo nixos-rebuild --flake $HOME/code/nix/padraic.nix#${nixosConfig.networking.hostName} switch --show-trace --verbose";
    };
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      download = "${config.home.homeDirectory}/downloads";
      extraConfig = { XDG_CODE_DIR = "${config.home.homeDirectory}/code"; };

      desktop = null;
      documents = null;
      pictures = null;
      publicShare = null;
      templates = null;
      videos = null;
      music = null;
    };
  };

  systemd.user.startServices = "sd-switch";
}
