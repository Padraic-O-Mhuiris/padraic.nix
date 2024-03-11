{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ pavucontrol ];

  # sound.enable is only meant for ALSA-based configurations
  sound.enable = false;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    socketActivation = true;
    systemWide = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Must set to false as conflicts with pipewire
  hardware.pulseaudio.enable = false;
}
