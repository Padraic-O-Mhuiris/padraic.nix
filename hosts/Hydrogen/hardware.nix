{ inputs, ... }:

{
  imports = [ inputs.hardware.nixosModules.dell-xps-15-9520-nvidia ];
}
