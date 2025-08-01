{ lib, config, pkgs-stable, ... }:
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
      environment.systemPackages = with pkgs-stable; [
        bridge-utils
        iproute2
      ];

      networking = {
        hostName = config.systemSettings.hostname; # Define your hostname.
        useNetworkd = true;
        networkmanager.enable = false; 
        bridges = {
          br0 = {
            interfaces = [ "eno1" ];
          };
        };

        interfaces = {
          eno1.useDHCP = false;
          br0.useDHCP = true;
        };
      };
    } 
    
    ( lib.mkIf ( config.networking.proxyUrl != null ) {
      networking.proxy.default = config.networking.proxy;
      networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    })
  ]); 
}
