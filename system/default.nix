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
    du-dust
    entr
    git
    file
    i7z
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

  time.timeZone = l.mkDefault "Europe/Dublin";
  system.stateVersion = l.mkDefault "24.05";
}
