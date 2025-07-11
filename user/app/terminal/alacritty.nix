{ pkgs, lib, config, ... }:
{
  options = {
    terminals.alacritty.enable = lib.mkEnableOption "enables alacritty terminal";
  };
  
  config = lib.mkIf config.terminals.alacritty.enable {
    home.packages = with pkgs; [
      alacritty
    ];

    programs.alacritty = {
      enable = true;
      settings = {
        window.opacity = lib.mkForce 0.85;
      };
    }; 
  };
}
