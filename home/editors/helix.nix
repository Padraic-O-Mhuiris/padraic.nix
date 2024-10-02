{
  pkgs,
  config,
  lib,
  ...
}:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      nil
      nixd
      nodePackages.bash-language-server
      lua-language-server
      llvmPackages_17.clang-tools
      ruff
      pyright
      lazygit
    ];
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        mouse = false;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        bufferline = "multiple";
        line-number = "relative";
        file-picker.hidden = false;
      };
      keys.normal = {
        # "C-g" = ":sh tmux popup -d \"#{pane_current_path}\" -xC -yC -w80% -h80% -E ${pkgs.lazygit}/bin/lazygit";
        # "C-t" = ":sh tmux popup -d \"#{pane_current_path}\" -xC -yC -w80% -h80% -E ${config.programs.tmux.shell}";
      };
    };
    ignores = [
      "/nix/store/*"
      ".direnv"
    ];
    # languages = {
    #   language-server = {
    #     beancount-language-server = {
    #       command = "${pkgs.beancount-language-server}/bin/beancount-language-server";
    #       args = [ "--stdio" ];
    #     };
    #   };
  };

  xdg.configFile."helix/languages.toml" = lib.mkForce {
    text = ''
      [[language]]
      name = "nix"
      auto-format = true
      formatter = { command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt" }

      [[language]]
      name = "cpp"
      auto-format = true
      formatter = { command = "${pkgs.llvmPackages_17.clang-tools}/bin/clang-format" }

      [[language]]
      name = "beancount"
      auto-format = true
      formatter = { command = "${pkgs.beancount}/bin/bean-format" } 


      [[language]]
      name = "cpp"
      auto-format = true
      formatter = { command = "${pkgs.llvmPackages_17.clang-tools}/bin/clang-format" }

      [[language]]
      name = "lua"
      auto-format = true
      formatter = { command = "${pkgs.luaformatter}/bin/lua-format" }

      [[language]]
      name = "python"
      auto-format = true
      formatter = { command = "${pkgs.python312Packages.black}/bin/black", args = ["--quiet", "-"] }
    '';
  };
}
