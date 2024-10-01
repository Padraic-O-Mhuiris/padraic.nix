{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./atuin.nix
    ./direnv.nix

    inputs.nix-index-database.hmModules.nix-index
  ];

  # -- Wezterm ---

  home.packages = with pkgs; [ wezterm ];
  home.sessionVariables = {
    TERMINAL = "${pkgs.wezterm}/bin/wezterm";
  };
  xdg.configFile."wezterm/wezterm.lua".text = ''
    --- imports
    local wezterm = require 'wezterm';

    --- helper functions
    local function deep_merge(t1, t2)
      for k, v in pairs(t2) do
        if type(v) == "table" and type(t1[k]) == "table" then
          deep_merge(t1[k], v)
        else
          t1[k] = v
        end
      end
      return t1
    end

    function file_exists(name)
       local f=io.open(name,"r")
       if f~=nil then io.close(f) return true else return false end
    end

    local config = {}

    local extra_config_path = wezterm.home_dir .. "/.config/wezterm/config.lua"
    if file_exists(extra_config_path) then
      local extra_config = dofile(wezterm.home_dir .. "/.config/wezterm/config.lua")
      config = deep_merge(config, extra_config)
    end

    return config
  '';

  # -- nix-index ---
  programs = {
    nix-index.enable = true;
    nix-index-database.comma.enable = true;
    zoxide = {
      enable = true;
      enableZshIntegration = true;
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
