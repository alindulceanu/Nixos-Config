{ pkgs-stable, ... }:
{
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs-stable; [
      xdg-desktop-portal
      xdg-desktop-portal-gtk
    ];
  };
}
