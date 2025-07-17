{ pkgs, config, lib, ... }:
{
  options = {
    hypr.enable = lib.mkEnableOption "enables hyprland config";
  };

  config = lib.mkIf config.hypr.enable {
    services.dunst = {
      enable = true;

      settings = {
        global = {
          width = 300;
          height = 300;
          offset = "30x50";
          origin = "top-right";
          transparency = 10;
        };

        urgency_normal.timeout = 3;
        urgency_critical.timeout = 0;
        urgency_low.timeout = 2;
      };
    };

    home.packages = with pkgs; [
      fuzzel
      kdePackages.dolphin
      hyprlock
      hyprpaper
      wlogout
    ];

    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        "$mod" = "SUPER";
        "$terminal" = "kitty";
        "$files" = "dolphin";
        "$launcher" = "fuzzel";

        input = {
          kb_layout = "ro";
        };

        exec-once = [
          "hyprpaper"
          "flameshot"
          "waybar"
        ];

        general = {
          gaps_in = 5;
          gaps_out = 5;
          border_size = 1;
        };

        monitor = "DP-1,1920x1080@75,1x1,1";

        bind = [
          "$mod, D, exec, $launcher"
          "$mod, E, exec, $files"
          "$mod, Q, exec, $terminal"
          "$mod, C, killactive"
          "$mod, M, exit"
          "$mod, J, exec, flameshot gui"
          "$mod, X, exec, wlogout"
        ] ++ 
          (builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
        9));
      };
    };
  };
}
