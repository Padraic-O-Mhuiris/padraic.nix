{ stateVersion, ... }: {
  home = {
    enableNixpkgsReleaseCheck = true;
    inherit stateVersion;
  };
}
