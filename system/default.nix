# This is the root configuration file for all configuration which will be
# shared amongst all hosts.

{ pkgs, l, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./boot
    ./nix
    ./networking
  ];

  environment.systemPackages = with pkgs; [
    bc
    binutils
    coreutils-full
    clang
    cmake
    curl
    dbus
    dnsutils
    du-dust
    entr
    git
    file
    i7z
    inetutils
    iw
    libnotify
    netcat
    nix-index
    nix-tree
    openssl
    pciutils
    patchelf
    usbutils
    psmisc
    sd
    stdenv.cc.cc.lib
    tree
    unzip
    vim
    whois
    wget
    xclip
    zlib
  ];

  location = {
    latitude = 53.28;
    longitude = -9.03;
  };

  time.timeZone = l.mkDefault "Europe/Dublin";

  # TODO Move this somewhere?
  # NOTE Necessary for gnupg gnome3 pinentry
  services.dbus.packages = [ pkgs.gcr ];

  system.stateVersion = l.mkDefault "24.05";
}
