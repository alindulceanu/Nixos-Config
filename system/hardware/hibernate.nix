{ lib, config, ... }:
{
  options = {
    hibernate = {
      enable = lib.mkEnableOption "Whether to enable system hibernation";

      swapOffset = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "Swap file physical offset";
      };

      rootPath = lib.mkOption {
        type = lib.types.path;
        default = "/.swapfile";
        description = "Swap file path";
      };
    };
  };

  config = lib.mkIf config.hibernate.enable {
    boot = {
      kernelParams = [
        "resume_offset=${config.hibernate.swapOffset}"
      ];

      resumeDevice = config.hibernate.rootPath;
    };
  };
}
