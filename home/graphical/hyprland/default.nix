{ inputs, config, pkgs, ... }:

let
  wallpaper =
    inputs.nix-wallpaper.packages.${pkgs.system}.default.overrideAttrs {
      backgroundColor = "#3b4252";
    };
  nixos_wallpaper_png = "${wallpaper}/share/wallpapers/nixos-wallpaper.png";
in {
  # NOTE We could use upstream hyprland module by importing it here but may be unstable
  imports = [ ../alacritty.nix ../fonts.nix ../wofi.nix ../waybar.nix ];

  systemd.user.targets.hyprland-session.Unit.Wants =
    [ "xdg-desktop-autostart.target" ];

  home = {
    packages = with pkgs; [
      hyprpaper
      inputs.pyprland.packages.${pkgs.system}.default
    ];

    file = {
      ".config/hypr/hyprpaper.conf".text = ''
        preload = ${nixos_wallpaper_png}
        wallpaper = eDP-1,${nixos_wallpaper_png}
        splash = false
        ipc = off
      '';
      ".config/hypr/pyprland.toml".text = ''
        [pyprland]
        plugins = [
          "scratchpads"
        ]

        [scratchpads.terminal]
        animation = ""
        command = "${config.home.sessionVariables.TERMINAL} --class alacritty-dd -e ${pkgs.tmux}/bin/tmux"
        class = "alacritty-dd"
        lazy = true
        size = "2560px 1600px"
        position = "640px 400px"
        margin = 0
        hysteresis = 0
        unfocus = "hide"
        excludes = "*"
      '';
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    enableNvidiaPatches = false; # This has been removed in the upstream package
    xwayland.enable = true;

    package = inputs.hyprland.packages.${pkgs.system}.default;

    settings = {
      "$mod" = "SUPER";
      input = {
        kb_layout = "gb";
        kb_options = "ctrl:nocaps";
      };
      misc = {
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
      };
      animations.enabled = false;
      "exec-once" =
        [ "pypr --debug /dev/null > /tmp/pypr_launch_log.txt 2>&1" ];
      xwayland.force_zero_scaling = true;
      monitor = "eDP-1,3840x2400@60,0x0,1.5";
      bind = [
        "$mod SHIFT, E, exec, pkill Hyprland"
        "$mod, q, killactive,"
        "$mod, f, fullscreen,"
        "$mod, d, exec, ${config.home.sessionVariables.LAUNCHER}"
        "$mod, z, exec, ${config.home.sessionVariables.EDITOR}"
        "$mod, x, exec, pypr toggle terminal"
      ] ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (x:
          let
            ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
          in [
            "$mod, ${ws}, workspace, ${toString (x + 1)}"
            "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
          ]) 10));
    };
  };
}
