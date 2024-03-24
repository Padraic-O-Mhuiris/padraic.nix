{ inputs, ... }:

let
  l = inputs.nixpkgs.lib.extend (_: lib: {

    isZfsFilesystem = cfg:
      l.attrsets.hasAttr "zfs"
      (cfg.boot.supportedFilesystems // cfg.boot.initrd.supportedFilesystems);

  });
in {
  _module.args = { inherit l; };

  flake = { inherit l; };
}
