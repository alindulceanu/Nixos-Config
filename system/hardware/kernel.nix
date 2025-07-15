{ pkgs-stable, ... }:
{
   boot = {
     kernelPackages = pkgs-stable.linuxPackages_latest;
     consoleLogLevel = 3;
     kernelParams = [
       "quiet"
       "usbcore.autosuspend=1" # Fixes the hang on login screen caused by the headset.
       "splash"
       "boot.shell_on_fail"
       "udev.log_priority=3"
       "rd.systemd.show_status=auto"
    ];
  };
}
