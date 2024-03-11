{
  description = "Padraic's NixOS configurations";

  # TODO Is there a convenient way to replicate this in a module and here?
  nixConfig = {
    substituters = [
      "https://cache.nixos.org?priority=10"
      "https://nix-community.cachix.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      debug = true;
      imports = [ ./nix ./lib ./hosts ./iso ];
      systems = [ "x86_64-linux" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: { };
      flake = { };
    };

  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-unstable"; };

    nixpkgs-master = { url = "github:nixos/nixpkgs/master"; };

    flake-utils = { url = "github:numtide/flake-utils"; };

    emacs = { url = "github:nix-community/emacs-overlay"; };

    flake-parts = { url = "github:hercules-ci/flake-parts"; };

    hardware = { url = "github:NixOS/nixos-hardware"; };

    nil = { url = "github:oxalica/nil"; };

    nixos-anywhere = {
      url = "github:numtide/nixos-anywhere";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = { url = "github:nix-community/impermanence"; };

    nur = { url = "github:nix-community/NUR"; };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nh = {
      url = "github:viperML/nh";
      inputs.nixpkgs.follows =
        "nixpkgs"; # override this repo's nixpkgs snapshot
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };
}
