{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [ dconf ];
    pointerCursor = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 36;
    };
  };
}
