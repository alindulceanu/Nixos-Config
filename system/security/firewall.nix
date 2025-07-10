{ config, lib, ... }:
{
  options = {
    firewall.enable = lib.mkEnableOption "enables firewall";
  };

  config = lib.mkIf config.firewall.enable {
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 22000 21027 ];
      allowedUDPPorts = [ 22000 21027 ];
    };
  };
}
