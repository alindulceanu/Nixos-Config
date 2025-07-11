{ lib, config, pkgs-stable, ... }:
{
  options = {
    audio.enable = lib.mkEnableOption "enables audio support";

    audio.backend = lib.mkOption {
      type = lib.types.enum [ "pipewire" "pulseaudio" ];
      default = "pipewire";
      description = "Audio backend to use (pipewire / pulseaudio)";
    };
  };

   config = lib.mkIf config.audio.enable ( lib.mkMerge [
     (lib.mkIf ( config.audio.backend == "pipewire" ) {
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
    })

    (lib.mkIf ( config.audio.backend == "pulseaudio" ) {
      services.pulseaudio = {
        enable = true;
        support32Bit = true;
      };

      environment.systemPackages = with pkgs-stable; [
        pavucontrol
      ];
    }) 
  ]);
}
