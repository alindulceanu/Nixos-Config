{ pkgs, lib, config,... }:
{
  options = {
    terminals.kitty.enable = lib.mkEnableOption "enables kitty terminal";
  };

  config = lib.mkIf config.terminals.kitty.enable {
    home.packages = with pkgs; [
      kitty
    ];
    programs.kitty = {
      enable = true;
      settings = {
        background_opacity = lib.mkForce 0.85;
        modify_font = "cell_width 90%";
        font_family = config.style.font.name;
        font_size = 12;
      };
    };
  };
}
