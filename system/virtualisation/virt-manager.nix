_: {

  programs.virt-manager.enable = true;

  users.groups.libvirtd.members = [ "padraic" ];

  virtualisation.libvirtd.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;
}
