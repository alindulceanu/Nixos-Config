{ lib, config, ... }:
{
  options = {
    dev.enable = lib.mkEnableOption "Toggles developer tools";
  };

  config.programs.direnv = lib.mkIf config.dev.enable {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
}
