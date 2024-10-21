{ config, pkgs, ... }:
{
  programs.gpg = {
    enable = true;
    mutableKeys = false;
    homedir = "${config.xdg.dataHome}/gnupg";
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableExtraSocket = true;
    enableScDaemon = true;
    grabKeyboardAndMouse = true;
    defaultCacheTtl = 3600;
    pinentryPackage = pkgs.pinentry-gnome3;
    extraConfig = ''
      allow-loopback-pinentry
    '';
    verbose = true;
  };

  # # NOTE Necessary for gnupg gnome3 pinentry
  # services.dbus.packages = [ pkgs.gcr ];

  systemd.user.sessionVariables.GNUPGHOME = "${config.xdg.dataHome}/gnupg";
}
