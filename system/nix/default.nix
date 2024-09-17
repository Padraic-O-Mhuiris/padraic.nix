{
  inputs,
  config,
  l,
  pkgs,
  ...
}:
{
  imports = [
    ./nixpkgs.nix
    ./substituters.nix
  ];

  nix = {
    # pin the registry to avoid downloading and evaling a new nixpkgs version every time
    registry = l.mapAttrs (_: v: { flake = v; }) inputs;

    package = pkgs.nixVersions.nix_2_23;

    # set the path for channels compat
    nixPath = l.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;

    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      flake-registry = "/etc/nix/registry.json";

      # for direnv GC roots
      keep-derivations = true;
      keep-outputs = true;

      trusted-users = [
        "root"
        "@wheel"
      ];
    };
  };
}
