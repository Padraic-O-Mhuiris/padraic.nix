{
  pkgs,
  modulesPath,
  l,
  inputs,
  ...
}:

{
  imports = [
    ./boot.nix
    (modulesPath + "/profiles/qemu-guest.nix")
    inputs.disko.nixosModules.disko
  ];

  disko.devices.disk = import ./disk.nix;
  swapDevices = [ ];
  services.openssh.enable = true;

  networking.useDHCP = l.mkDefault true;
  networking.hostName = "Carbon";
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "24.05";

  users = {
    defaultUserShell = pkgs.bashInteractive;
    mutableUsers = false;
    enforceIdUniqueness = true;
    users.root.hashedPassword = "!"; # Disables login for the root user
  };

  users.users.padraic = {
    isNormalUser = true;
    createHome = true;
    hashedPassword = "$6$7RhoYiLu0Xn50HZD$pOIypZUz6aALwRt4SlsckKmTFo0r6fHh5zbSTLBQGkrPuoJS.7bJirx936XensJSlkn0e472nKjzE7Y4tv7td0";
    group = "users";
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEFlro/QUDlDpaA1AQxdWIqBg9HSFJf9Cb7CPdsh0JN7"
    ];
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    configure = {
      customRC = ''
        colorscheme habamax
      '';

      packages.packages = {
        start = [ pkgs.vimPlugins.nerdtree ];
      };
    };
  };
}
