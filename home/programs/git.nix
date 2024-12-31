{ pkgs, ... }: # TODO Add git settings
{

  home.packages = with pkgs; [ lazygit ];

  home.shellAliases."lg" = "${pkgs.lazygit}/bin/lazygit";

  programs.git = {
    enable = true;
    signing.signByDefault = true;
  };
}
