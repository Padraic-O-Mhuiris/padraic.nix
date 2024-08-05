{ config, ... }:

{
  imports = [
    # ./atuin.nix
    ./direnv.nix
    ./oh-my-posh.nix
    # ./starship.nix
    ./zoxide.nix
    ./tmux.nix
    ./nix-index-database.nix
  ];

  programs.zsh = {
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

  programs.nix-index.enableZshIntegration = true;
}
