{ config, pkgs, ... }:

{
  programs.gpg = {
    enable = true;
    mutableKeys = false;
    homedir = "${config.xdg.dataHome}/gnupg";
  };

  services.gpg-agent = {
    enable = true;
    enableExtraSocket = true;
    enableScDaemon = true;
    grabKeyboardAndMouse = true;
    defaultCacheTtl = 3600;
    pinentryFlavor = "gnome3";
    # TODO Condition emacs pinentry on whether emacs is installed or not
    extraConfig = ''
      allow-emacs-pinentry
      allow-loopback-pinentry
    '';
    verbose = true;
  };

  home.packages = with pkgs; [ pinentry-gnome ];

  systemd.user.sessionVariables.GNUPGHOME = "${config.xdg.dataHome}/gnupg";
}
