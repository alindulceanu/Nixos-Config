{ config, lib, ... }:
{
  options = {
    automount.enable = lib.mkEnableOption "enables automount";
  };

  config = lib.mkIf config.automount.enable {
    services.devmon.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;
  };
}
