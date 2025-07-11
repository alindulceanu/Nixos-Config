{ lib, config, ... }:
{
  options = {
    networking.enable = lib.mkEnableOption "enables networking";

    networking.proxyUrl = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Assigns a proxy if available";
    };
  };
  config = lib.mkIf config.networking.enable ( lib.mkMerge [
    { 
      networking.hostName = config.systemSettings.hostname; # Define your hostname.
      networking.networkmanager.enable = true; 
    } 
    
    ( lib.mkIf ( config.networking.proxyUrl != null ) {
      networking.proxy.default = config.networking.proxy;
      networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    })
  ]); 
}
