{ config, ... }:

{
  imports =
    [ ./direnv.nix ./oh-my-posh.nix ./starship.nix ./zoxide.nix ./tmux.nix ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    enableVteIntegration = true;
    autocd = true;
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
    historySubstringSearch.enable = true;
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
        "colored-man-pages"
        "command-not-found"
        "extract"
      ];
    };
  };
}
