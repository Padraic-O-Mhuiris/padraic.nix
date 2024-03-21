{
  nvme = {
    type = "disk";
    device = "/dev/disk/by-id/nvme-PC_SN810_NVMe_WDC_1024GB_222320805140";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          type = "EF00";
          size = "1GB";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
          };
        };
        swap = {
          size = "12G";
          content = {
            type = "swap";
            randomEncryption = true;
          };
        };

        zroot = {
          size = "100%";
          content = {
            type = "zfs";
            pool = "rpool";
          };
        };
      };
    };
  };
}
