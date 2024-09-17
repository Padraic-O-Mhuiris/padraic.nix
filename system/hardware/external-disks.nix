_: {
  programs.gnome-disks.enable = true;

  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };
}
