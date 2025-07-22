{ pkgs, config, lib, ... }:
{
  options = {
    hypr = {
      enable = lib.mkEnableOption "enables hyprland config";

      monitor = lib.mkOption {
        description = "Defines monitor parameters"; # todo multiple monitors
        type = lib.types.submodule {
          options = {
            name = lib.mkOption {
              type = lib.types.str;
              default = "DP-1";
              description = "Name of the monitor in hyprctl";
            };

            resolution = lib.mkOption {
              type = lib.types.str;
              default = "1920x1080";
              description = "Sets the monitor resolution";
            };

            frequency = lib.mkOption {
              type = lib.types.str;
              default = "75";
              description = "Sets the monitor framerate";
            };
          };
        };
      };

      naturalScroll = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Toggles natural scrolling";
      };
    };
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

    # programs.hyprpanel = {
    #   enable = true;
    #   settings = {
    #     modules = {
    #       center = [
    #         "notification-daemon"
    #         "volume"
    #         "brightness"
    #         "network"
    #         "battery"
    #       ];
    #     };
    #
    #     notification-daemon = {
    #       max_notifications = 5;
    #       timeout = 5000;
    #     };
    #   };
    # };

    home.file = {
      ".config/hypr/scripts/toggle-fuzzel" = {
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

      ".config/hypr/scripts/open-ranger" = {
        text = ''
          #!/usr/bin/env bash
          kitty ranger
        '';

        executable = true;
      };

      ".config/hypr/scripts/open-nvim" = {
        text = ''
          #!/usr/bin/env bash
          kitty nvim
        '';

        executable = true;
      };

      # ".config/hypr/scripts/toggle-hyprpanel" = {
      #   text = ''
      #     #!/usr/bin/env bash
      #     if pgrep -x hyprpanel > /dev/null; then
      #         pkill hyprpanel
      #     else
      #         hyprpanel &
      #     fi
      #   '';
      #
      #   executable = true;
      # };
    };

    home.packages = with pkgs; [
      fuzzel
      kdePackages.dolphin
      hyprlock
      ranger
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
          natural_scroll = config.hypr.naturalScroll;
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

        monitor = "${config.hypr.monitor.name},${config.hypr.monitor.resolution}@${config.hypr.monitor.frequency},1x1,1";

        bind = [
          "$mod, E, exec, ~/.config/hypr/scripts/open-ranger"
          "$mod SHIFT, E, exec, ~/.config/hypr/scripts/open-nvim"
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
          "$mod, N, exec, ~/.config/hypr/scripts/toggle-hyprpanel"
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
