{ home, ... }: {
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
    imports = [ "${home}" "${home}/windowManager/i3" ];
    home.homeDirectory = "/home/padraic";
  };

}
