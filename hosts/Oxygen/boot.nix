_: {
  # TODO This should ideally be host specific but some values may be globally
  # relevant
  boot = {
    kernelModules = [ "kvm-intel" ];

    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usbhid"
      "usb_storage"
      "sd_mod"
      "rtsx_pci_sdmmc"
    ];
  };
}
