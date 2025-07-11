{ lib, config, pkgs-stable, ... }:
{
  options = {
    spice.enable = lib.mkEnableOption "enables spice server for VMs";
  };

  config = lib.mkIf config.spice.enable {
    services.spice-vdagentd.enable = true;
    services.udev.packages = with pkgs-stable; [spice-vdagent];
  };
}
