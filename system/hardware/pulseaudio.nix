{ lib, pkgs-stable, ... }:
{
  services.pulseaudio = {
    enable = lib.mkDefault false;
    support32Bit = true;
  };

  environment.systemPackages = with pkgs-stable; [
    pavucontrol
  ];
}
