{ pkgs, ... }:
let
  package = pkgs.emacs-unstable;
in
{
  programs.emacs = {
    enable = true;
    inherit package;
  };

  services.emacs = {
    enable = true;
    inherit package;
    client.enable = true;
    # Sets $EDITOR
    defaultEditor = true;
    startWithUserSession = true;
    extraOptions = [ ];
  };

  home.packages = with pkgs; [
    (ripgrep.override { withPCRE2 = true; })
    fd
    (aspellWithDicts (
      dicts: with dicts; [
        en
        en-computers
        en-science
      ]
    ))
    rust-analyzer
    # nixfmt
    nil
    marksman
    parinfer-rust-emacs
    emacsPackages.pdf-tools
    vscode-langservers-extracted
    nodePackages_latest.prettier
    nodePackages_latest.bash-language-server
    llvmPackages_18.clang-unwrapped
    ccls
    semgrep
    sqlfluff
  ];
}
