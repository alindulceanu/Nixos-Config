{ pkgs, config, lib, userSettings, systemSettings, ... }:
{
  options = {
    hypr.enable = lib.mkEnableOption "enables hyprland config";
  };

  config = lib.mkIf config.hypr.enable {
    home.packages = with pkgs; [
      fuzzel
      kdePackages.dolphin
      hyprlock
      hyprpaper
      dunst
    ];

    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        "$mod" = "SUPER";
        "$terminal" = "kitty";
        "$files" = "dolphin";
        "$launcher" = "fuzzel";

        exec-once = [
          "hyprpaper"
          "flameshot"
          "waybar"
        ];

        monitor = "DP-1,1920x1080@75,1x1,1";

        bind = [
          "$mod, D, exec, $launcher"
          "$mod, E, exec, $files"
          "$mod, Q, exec, $terminal"
          "$mod, C, killactive"
          "$mod, M, exit"
          "$mod, J, exec, flameshot gui"
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
