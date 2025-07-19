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

    home.file.".config/hypr/scripts/toggle-fuzzel" = {
      text = ''
        #!/usr/bin/env bash
        if pgrep -x fuzzel >/dev/null; then
            pkill -x fuzzel
        else
          fuzzel &
        fi
      '';

      executable = true;
    };

    home.packages = with pkgs; [
      fuzzel
      kdePackages.dolphin
      hyprlock
      hyprpaper
      wlogout
      (flameshot.override { enableWlrSupport = true; })
    ];

    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        "$mod" = "SUPER";
        "$terminal" = "kitty";
        "$files" = "dolphin";

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
          "$mod, E, exec, $files"
          "$mod, Q, exec, $terminal"
          "$mod, C, killactive"
          "$mod, L, exec, hyprlock"
          "$mod, M, exit"
          "$mod, F, fullscreen"
          "$mod, V, togglefloating"
          ", Print, exec, flameshot gui"
          "$mod, X, exec, wlogout"
          "$mod SHIFT, space, layoutmsg, togglesplit"
          "$mod SHIFT, H, exec, hyprctl dispatch swapwindow l"
          "$mod SHIFT, L, exec, hyprctl dispatch swapwindow r"
          "$mod SHIFT, K, exec, hyprctl dispatch swapwindow u"
          "$mod SHIFT, J, exec, hyprctl dispatch swapwindow d"
        ] ++ 
          (builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
        9));

        bindr = [
          "$mod, SUPER_L, exec, ~/.config/hypr/scripts/toggle-fuzzel"
        ];

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
      };
    };
  };
}
