{ inputs, ... }:
{
  imports = [
    inputs.hardware.nixosModules.common-hidpi
    inputs.hardware.nixosModules.common-pc
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.common-cpu-amd
  ];

  hardware.nvidia.prime.nvidiaBusId = "PCI:9:0:0";
  hardware.nvidia.prime.amdgpuBusId = "PCI:0:2:0";
}
