{ ... }:
{
  services.hyprpaper.settings = {

    ipc = "on";
    splash = true;
    splash_offset = 2.0;

    preload = [
      "~/Media/Wallpapers/"
    ];

    wallpapers = [
      "DP-1,~/Media/Wallpapers/background.png"
    ];
  };
}
