{ lib, config, ... }:
let
  settings = import ./settings.nix;
  style = import ./style.nix;
in
{ 
  options = {
    waybar.enable = lib.mkEnableOption "Enables waybar";
  };

  config = lib.mkIf config.waybar.enable {
    programs.waybar = {
      enable = true;
      style = style;
      settings = settings;
    };
  };
}
