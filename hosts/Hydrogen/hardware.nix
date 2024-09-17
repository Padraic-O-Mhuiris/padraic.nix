{ inputs, pkgs, l, ... }: {
  imports = [
    inputs.hardware.nixosModules.common-hidpi
    inputs.hardware.nixosModules.dell-xps-15-9520-nvidia
  ];

  hardware.nvidia.prime.sync.enable = l.mkForce false;

  # This pins the mesa version to what is specified by Hyprland
  hardware.graphics.package =
    inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.system}.mesa.drivers;
}
