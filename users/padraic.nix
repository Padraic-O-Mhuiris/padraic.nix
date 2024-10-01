{
  config,
  home,
  pkgs,
  ...
}:
{
  imports = [ ./home.nix ];

  # We enable this for clarity but most shell configuration is in home
  programs.zsh.enable = true;

  users.users.padraic = {
    isNormalUser = true;
    createHome = true;

    useDefaultShell = false;
    shell = pkgs.zsh;

    # passwordFile = config.sops.secrets."user@${name}".path;
    # TODO Figure out why sops is not working for this on first installation?
    hashedPassword = "$6$7RhoYiLu0Xn50HZD$pOIypZUz6aALwRt4SlsckKmTFo0r6fHh5zbSTLBQGkrPuoJS.7bJirx936XensJSlkn0e472nKjzE7Y4tv7td0";
    group = "users";
    extraGroups = [
      "wheel"
      "input"
      "networkmanager"
      "audio"
      "pipewire"
      "video"
      "docker"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEFlro/QUDlDpaA1AQxdWIqBg9HSFJf9Cb7CPdsh0JN7"
    ];
  };

  # Always login with padraic
  services.displayManager.autoLogin.user = if config.services.xserver.enable then "padraic" else null;

  home-manager.users.padraic =
    { config, osConfig, ... }:
    {
      # NOTE All /home related modules should be specified here
      imports = [
        "${home}"

        "${home}/browsers"

        "${home}/terminal"

        # "${home}/shell/zsh"
        "${home}/editors/helix.nix"

        "${home}/services/bluetooth.nix"
        "${home}/services/redshift.nix"
        "${home}/services/flameshot.nix"
        "${home}/services/nm.nix"

        "${home}/programs/git.nix"
        "${home}/programs/ssh.nix"

        "${home}/notes"

        "${home}/infosec/gnupg.nix"
        "${home}/infosec/pass.nix"

        "${home}/graphical/i3"
      ];

      home.homeDirectory = "/home/padraic";

      # TODO Move these to somewhere
      home.packages = with pkgs; [
        gimp-with-plugins
        zoom-us
        slack
        element-desktop
        discord
        spotify
        telegram-desktop
        libreoffice
        ledger-live-desktop
        teams-for-linux
        bitwarden
        qbittorrent
        vlc
      ];

      sops = {
        inherit (osConfig.sops) defaultSopsFile;
        age.sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
      };

      programs = {
        git = {
          userEmail = "patrick.morris.310@gmail.com";
          userName = "Padraic-O-Mhuiris";
          signing.key = "18F528675193C19214A73F1DEF4CEF1AF71A4EDD";
        };

        gpg.publicKeys = [
          {
            text = ''
              -----BEGIN PGP PUBLIC KEY BLOCK-----

              mDMEZaLSohYJKwYBBAHaRw8BAQdAjjBWHkp/5DuqnbystGUXCyZLorvzLe13Aa0e
              +a+9YNK0L1BhdHJpY2sgSCBNb3JyaXMgPHBhdHJpY2subW9ycmlzLjMxMEBnbWFp
              bC5jb20+iI4EExYKADYWIQQY9ShnUZPBkhSnPx3vTO8a9xpO3QUCZaLSogIbAQQL
              CQgHBBUKCQgFFgIDAQACHgUCF4AACgkQ70zvGvcaTt0iegD+MgSaI4JQGzyxqPH4
              xiBPvS7WaGKwBSFzxrJRN1G+rJIA/3/xn39apL+7DuzFfKe7+OP3jfHMMErSsp7S
              WyTJDyMGuDMEZaLTeRYJKwYBBAHaRw8BAQdAMnhqdI6qfPPy2gg1/OwvVzrvu/jm
              Zym+XLz+TdHC7qOI9QQYFgoAJhYhBBj1KGdRk8GSFKc/He9M7xr3Gk7dBQJlotN5
              AhsCBQkFo5qAAIEJEO9M7xr3Gk7ddiAEGRYKAB0WIQS7biGZohmT2vhfyV91Y6Tu
              HWtT0wUCZaLTeQAKCRB1Y6TuHWtT03GSAQC7EaCGPCC6piz+ziZiNGnIGGFM4VQX
              ZjZ3kNxhmOUn1wEAvQSt8zK97gF4JguLNjtxz1XIAx7Rol6etN+8fV71SwFAogEA
              m8Ltwj4RK4KQXHyRelvseFsSWD5IM8iq/ua4TnMJSmYA/0580zrrvNOnrQUd0Z6K
              KBFgD+Q6JWbILol3zR53e7EIuDgEZaLToBIKKwYBBAGXVQEFAQEHQHyz5+gsTHMx
              Xfp80ha8erN5aMMafu5Alx80iftbFsI4AwEIB4h+BBgWCgAmFiEEGPUoZ1GTwZIU
              pz8d70zvGvcaTt0FAmWi06ACGwwFCQWjmoAACgkQ70zvGvcaTt3u0AEA2ig/cg6b
              k7JsBhPOzGts6YWqfbkEgSgZQpuc6rwXt1cA+gJETrRAfrRckxzsDKiQv/5FiY5A
              +wCK8eicZVfskIkPuDMEZaLTtRYJKwYBBAHaRw8BAQdArx5kSCm3WJbw0mj8oAb1
              bf6ATCNb7nywA/aXWrPat4SIfgQYFgoAJhYhBBj1KGdRk8GSFKc/He9M7xr3Gk7d
              BQJlotO1AhsgBQkFo5qAAAoJEO9M7xr3Gk7daEQA/jJwnfR+geI99bwAEpTpqW7f
              BpWBtXRV3cZLM3s0f6ByAQCgo1/ilNFUP4AFkTnJqMVUTxKpKZhOrvVZCh50cqYo
              Cw==
              =3oRa
              -----END PGP PUBLIC KEY BLOCK-----
            '';
            trust = 5;
          }
        ];
      };
    };
}
