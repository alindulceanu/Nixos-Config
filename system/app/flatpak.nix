{ pkgs-stable, config, lib, ... }:
{
  options = {
    flatpak.enable = lib.mkEnableOption "enables flatpak";
  };

  config = lib.mkIf config.flatpak.enable {
    services.flatpak.enable = true;
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs-stable; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
      ];
    };
  };
}
