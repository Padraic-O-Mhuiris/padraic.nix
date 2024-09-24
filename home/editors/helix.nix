{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [ nixd ];
    settings = {
      theme = "catppuccin_mocha";
      editor = {
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
        "C-g" = ":sh tmux popup -d \"#{pane_current_path}\" -xC -yC -w80% -h80% -E ${pkgs.lazygit}/bin/lazygit";
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
      }
    ];
  };
}
