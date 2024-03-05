{
  nvme = {
    type = "disk";
    device =
      "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_2TB_S4J4NF0NC04658B";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          type = "EF00";
          size = "64M";
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

  sda = {
    type = "disk";
    device = "/dev/disk/by-id/ata-Samsung_SSD_860_EVO_2TB_S4X1NJ0NB04835M";
    content = {
      type = "gpt";
      partitions = {
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
