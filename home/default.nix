{ stateVersion, pkgs, ... }: {
  home = {
    packages = with pkgs; [ htop ];

    enableNixpkgsReleaseCheck = true;
    inherit stateVersion;
  };
}
