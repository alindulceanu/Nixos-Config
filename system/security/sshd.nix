{ config, lib, ... }:
{
  options = {
    ssh.enable = lib.mkEnableOption "enables ssh";
  };

  config = lib.mkIf config.ssh.enable {
    services.openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "no";
      };
    };
  };
}
