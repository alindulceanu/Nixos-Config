{ pkgs, lib, userSettings, ... }:
{
  home.packages = with pkgs; [
    kitty
  ];
  programs = {
    kitty = {
      enable = true;
      settings = {
        background_opacity = lib.mkForce "0.85";
        modify_font = "cell_width 90%";
        font_family = userSettings.font;
        font_size = 12;
      };
    };
  };
}
