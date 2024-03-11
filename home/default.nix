{ stateVersion, pkgs, ... }: {

  imports = [ ./programs ];

  home = {
    packages = with pkgs; [ htop ];

    enableNixpkgsReleaseCheck = true;
    inherit stateVersion;
  };

  systemd.user.startServices = "sd-switch";
}
