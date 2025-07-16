{ lib, config, ... }:
{
  imports = [
    ./bootScreen.nix
  ];

  options = {
    settings = lib.mkOption {
      type = lib.types.submodule {
        options = {
          timezone = lib.mkOption {
            type = lib.types.str;
            default = "Europe/Bucharest";
            description = "Sets timezone";
          };

          locale = lib.mkOption {
            type = lib.types.str;
            default = "en_US.UTF-8";
            description = "Sets locales";
          };
        }; 
      };
    };
  };

  config = {
    time.timeZone = config.settings.timezone;

    i18n.defaultLocale = config.settings.locale;

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "ro_RO.UTF-8";
      LC_IDENTIFICATION = "ro_RO.UTF-8";
      LC_MEASUREMENT = "ro_RO.UTF-8";
      LC_MONETARY = "ro_RO.UTF-8";
      LC_NAME = "ro_RO.UTF-8";
      LC_NUMERIC = "ro_RO.UTF-8";
      LC_PAPER = "ro_RO.UTF-8";
      LC_TELEPHONE = "ro_RO.UTF-8";
      LC_TIME = "ro_RO.UTF-8";
    }; 
  };
}
