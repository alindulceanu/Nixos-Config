{ config, lib, inputs, pkgs, ... }:
let
  themePath = "${inputs.self}/themes/${config.style.theme}/${config.style.theme}.yaml";
  themePolarity = lib.removeSuffix "\n" (builtins.readFile ("${inputs.self}/themes"+("/"+config.style.theme)+"/polarity.txt"));
  backgroundUrl = builtins.readFile ("${inputs.self}/themes"+("/"+config.style.theme)+"/backgroundurl.txt");
  backgroundSha256 = builtins.readFile ("${inputs.self}/themes/${config.style.theme}/backgroundsha256.txt");

in {
  imports = [ inputs.stylix.homeModules.stylix ];

  options = {
    style = lib.mkOption {
      type = lib.types.submodule {
        options = {

          theme = lib.mkOption {
            type = lib.types.str;
            default = "ashes";
            description = "Select a system theme from themes/";
          };

          font = lib.mkOption {
            type = lib.types.submodule {
              options = {
                name = lib.mkOption {
                  type = lib.types.str;
                  default = "FiraCode Nerd Font";
                  description = "Select a system font family";
                };

                package = lib.mkOption {
                  type = lib.types.package;
                  default = pkgs.nerd-fonts.fira-code;
                  description = "Select the font package";
                };
              };
            };
            description = "Font configuration (name + package)";
          };

          cursor = lib.mkOption {
            type = lib.types.submodule {
              options = {
                name = lib.mkOption {
                  type = lib.types.str;
                  default = "Bibata-Modern-Ice";
                  description = "Select a system cursor";
                };

                package = lib.mkOption {
                  type = lib.types.package;
                  default = pkgs.bibata-cursors;
                  description = "Select the cursor package";
                };
              };
            };
            description = "Cursor configuration (name + package)";
          };

        };
      };

      description = "Visual style options including theme, font, and cursor.";
    };
  };
  
  config.stylix = {
    enable = true;

    targets.nixvim.enable = false;
    targets.fuzzel.enable = true;

    image = pkgs.fetchurl {
      url = backgroundUrl;
      sha256 = backgroundSha256;
    };

    base16Scheme = themePath;
    fonts = {
      monospace = {
        name = config.style.font.name;
        package = config.style.font.package;
      };

      serif = {
        name = config.style.font.name;
        package = config.style.font.package;
      };
      
      sansSerif = {
        name = config.style.font.name;
        package = config.style.font.package;
      };

      emoji = {
        name = "Noto Emoji";
        package = pkgs.noto-fonts-monochrome-emoji;
      };

      sizes = {
        terminal = 18;
        applications = 12;
        popups = 12;
        desktop = 12;
      };
    };
    
    opacity = {
      terminal = 0.8;
      applications = 1.0;
      popups = 0.9;
      desktop = 1.0;
    };

    polarity = themePolarity;

    cursor = {
      name = config.style.cursor.name;
      package = config.style.cursor.package;
      size = 24;
    };

    #qt = {
    #  enable = true;
    #  style = {
#	package = pkgs.libsForQt5.breeze-qt5;
#	name = "breeze-dark";
    #  };
    #  platformTheme = "kde";
    #};

    #fonts.fontconfig.defaultFonts = {
      #monospace = [ config.font.name ];
      #sansSerif = [ config.font.name ];
     # serif = [ config.font.name ];
    #};
  };
}
