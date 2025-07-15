{ pkgs-stable, lib, config, ... }:
{
  options = {
    bootScreen.theme = lib.mkOption {
      type = lib.types.str;
      default = "rings";
      description = "Sets the boot screen theme from plymouth";
    };
  };

  config.boot = {
    plymouth = {
      enable = true;
      theme = config.bootScreen.theme;
      themePackages = with pkgs-stable; [ 
        (adi1090x-plymouth-themes.override {
          selected_themes = [ config.bootScreen.theme ];
         })
      ];
    };
    initrd.verbose = false;
    loader.timeout = 0;
  };
}
