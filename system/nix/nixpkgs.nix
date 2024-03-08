{ l, ... }: { nixpkgs = { config.allowUnfree = l.mkDefault true; }; }
