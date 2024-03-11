{ l, pkgs, config, ... }:

{
  # We always want to use the most up-to-date kernel version but also maintain
  # compatability with zfs if it is used
  boot.kernelPackages = if (l.isZfsFilesystem config) then
    pkgs.zfs.latestCompatibleLinuxPackages
  else
    pkgs.linuxPackages_latest;

  boot.tmp.cleanOnBoot = true;
}
