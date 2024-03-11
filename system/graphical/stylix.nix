{ inputs, pkgs, ... }:

let base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
in {
  imports = [ inputs.stylix.nixosModules.stylix ];
  stylix = {
    inherit base16Scheme;
    image = pkgs.fetchurl {
      url =
        "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
      sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
    };
    autoEnable = false;
    homeManagerIntegration = {
      autoImport = true;
      followSystem = true;
    };
  };
}
