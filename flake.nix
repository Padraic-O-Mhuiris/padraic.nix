{
  description = "Padraic's NixOS configurations";

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

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-wallpaper = {
      url = "github:lunik1/nix-wallpaper";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    stylix = { url = "github:danth/stylix"; };

    nh = {
      url = "github:viperML/nh";
      inputs.nixpkgs.follows =
        "nixpkgs"; # override this repo's nixpkgs snapshot
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
