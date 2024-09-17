{ inputs, config, self, ... }:
let
  l = inputs.nixpkgs.lib.extend (_: lib: {
    isZfsFilesystem = cfg:
      l.attrsets.hasAttr "zfs"
      (cfg.boot.supportedFilesystems // cfg.boot.initrd.supportedFilesystems);

    log = expr: builtins.trace expr expr;

    /* This function takes a nix store path, validates the hash matches this
       project and replaces the store path with the root
    */
    alignStorePathToRoot = path:
      let
        pathComponents = lib.strings.splitString "/" path;
        nixStorePath =
          lib.concatStringsSep "/" (lib.sublist 0 4 pathComponents);
      in if (nixStorePath != self.outPath) then
        abort
        "path is not a child of flake outPath: path: ${path}, outPath: ${self.outPath}"
      else
        let
          pathComponentsLen = builtins.length pathComponents;
          nixStorePathContents = lib.concatStringsSep "/"
            (lib.sublist 4 pathComponentsLen pathComponents);
        in "${config.flake.root}/${nixStorePathContents}";
  });
in {
  _module.args = { inherit l; };

  flake = { inherit l; };
}
