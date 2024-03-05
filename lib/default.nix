{ inputs, ... }:
let inherit (inputs.nixpkgs-lib) lib;
in { flake = { lib = lib // { }; }; }
