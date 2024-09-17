_: {
  perSystem = { config, self', inputs', pkgs, system, ... }: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        nixfmt-rfc-style
        statix
        git
        nodePackages.prettier
        sops
        ssh-to-age
      ];
      DIRENV_LOG_FORMAT = "";
      shellHook = ''
        ${config.pre-commit.installationScript}
      '';
    };
  };
}
