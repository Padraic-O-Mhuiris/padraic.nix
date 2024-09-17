{ pkgs, ... }: {
  users = {
    defaultUserShell = pkgs.bashInteractive;
    mutableUsers = false;
    enforceIdUniqueness = true;
    users.root.hashedPassword = "!"; # Disables login for the root user
  };
}
