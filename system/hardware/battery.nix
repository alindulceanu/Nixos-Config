{ config, lib, pkgs-stable, ... }:
{
  options = {
    bat = {
      enable = lib.mkEnableOption "Toggles battery optimizations for laptops";
    };
  };

  config = lib.mkIf config.bat.enable {
    environment.systemPackages = with pkgs-stable; [
      powertop
    ];

    services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        SCHED_POWERSAVE_ON_BAT = 1;
        NMI_WATCHDOG = 0;
      };
    };

    services.upower.enable = true;
  };
}
