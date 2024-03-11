{ home, l, config, ... }:
{
  users.users.padraic = {

    isNormalUser = true;
    # passwordFile = config.sops.secrets."user@${name}".path;
    # TODO Figure out why sops is not working for this on first installation?
    hashedPassword =
      "$6$7RhoYiLu0Xn50HZD$pOIypZUz6aALwRt4SlsckKmTFo0r6fHh5zbSTLBQGkrPuoJS.7bJirx936XensJSlkn0e472nKjzE7Y4tv7td0";
    group = "users";
    extraGroups = [ "wheel" "input" "networkmanager" "audio" ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEFlro/QUDlDpaA1AQxdWIqBg9HSFJf9Cb7CPdsh0JN7"
    ];
  };

  home-manager.users.padraic = { ... }: {
    # NOTE All /home related modules should be specified here
    imports = [
      "${home}"
      "${home}/windowManager/i3"
      "${home}/services/bluetooth.nix"
      "${home}/programs/git.nix"
    ];
    home.homeDirectory = "/home/padraic";

    programs.git = {
      userEmail = "patrick.morris.310@gmail.com";
      userName = "Padraic-O-Mhuiris";
      signing.key = "18F528675193C19214A73F1DEF4CEF1AF71A4EDD";
    };
  };
} // (l.mkIf config.xserver.enable {
  # Auto login with padraic
  services.xserver.displayManager.autoLogin.user = "padraic";
})
