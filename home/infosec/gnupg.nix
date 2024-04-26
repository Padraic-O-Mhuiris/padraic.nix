{ config, pkgs, ... }:

{
  # TODO Can this be derived somewhat rather than a static path
  home.sessionVariables.SSH_AUTH_SOCK =
    "/run/user/1000/gnupg/d.u7ukbdjqgf6bp5z34ihyfrkj/S.gpg-agent";

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
