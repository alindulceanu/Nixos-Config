{ pkgs-stable, lib, ... }:
{
  security.rtkit.enable = true;
    services.pipewire = {
      enable = lib.mkDefault true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    environment.systemPackages = with pkgs-stable; [
      pwvucontrol
    ];
}
