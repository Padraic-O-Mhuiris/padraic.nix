{ config, pkgs, inputs, ... }:
let weztermPkg = pkgs.wezterm;
in {
  imports = [
    ./atuin.nix
    ./direnv.nix

    inputs.nix-index-database.hmModules.nix-index
  ];

  # -- Wezterm ---

  home.packages = [ weztermPkg ] ++ (with pkgs; [ ripgrep lazygit ]);

  home.sessionVariables = { TERMINAL = "${weztermPkg}/bin/wezterm"; };

  xdg.configFile."wezterm/wezterm.lua".source =
    config.lib.file.mkOutOfStoreSymlink
    "/home/padraic/code/nix/padraic.nix/home/terminal/wezterm/wezterm.lua";

  programs = {
    nix-index.enable = true;
    nix-index-database.comma.enable = true;
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      useTheme = "tokyonight_storm";
    };
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      enableVteIntegration = true;
      autocd = true;
      historySubstringSearch.enable = true;
      history = {
        expireDuplicatesFirst = true;
        extended = true;
        ignoreDups = true;
        ignorePatterns = [ ];
        ignoreSpace = true;
        path = "${config.xdg.dataHome}/zsh/zsh_history";
        save = 100000;
        share = true;
      };
      # https://github.com/nix-community/home-manager/blob/2f23fa308a7c067e52dfcc30a0758f47043ec176/modules/programs/wezterm.nix#L10
      initExtra = ''
        source ${weztermPkg}/etc/profile.d/wezterm.sh
      '';
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "aliases"
          "sudo"
          "direnv"
          "emoji"
          "encode64"
          "jsontools"
          "systemd"
          "dirhistory"
          "command-not-found"
          "colored-man-pages"
          "extract"
        ];
      };
    };
  };
}
