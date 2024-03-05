{ inputs, ... }:

let l = inputs.nixpkgs.lib;
in {
  _module.args = { inherit l; };

  flake = { inherit l; };
}
