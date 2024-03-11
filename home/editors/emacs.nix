{ pkgs, ... }:

let package = pkgs.emacs-unstable;
in {

  programs.emacs = {
    enable = true;
    inherit package;
  };

  services.emacs = {
    enable = true;
    inherit package;
    client.enable = true;
    defaultEditor = true;
    startWithUserSession = true;
    extraOptions = [ ];
  };

  home.packages = with pkgs; [
    (ripgrep.override { withPCRE2 = true; })
    fd
    (aspellWithDicts (dicts: with dicts; [ en en-computers en-science ]))
    rust-analyzer
    nixfmt
    nil
    marksman
    vscode-langservers-extracted
    nodePackages_latest.prettier
    nodePackages_latest.bash-language-server
    llvmPackages_9.clang-unwrapped
    ccls
    semgrep
    sqlfluff
  ];
}
