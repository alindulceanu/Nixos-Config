{ config, lib, inputs, userSettings, pkgs, ... }:
let
  themePath = "${inputs.self}/themes/${userSettings.theme}/${userSettings.theme}.yaml";
  themePolarity = lib.removeSuffix "\n" (builtins.readFile ("${inputs.self}/themes"+("/"+userSettings.theme)+"/polarity.txt"));
  backgroundUrl = builtins.readFile ("${inputs.self}/themes"+("/"+userSettings.theme)+"/backgroundurl.txt");
  backgroundSha256 = builtins.readFile ("${inputs.self}/themes/sha256.txt");

in {
  imports = [ inputs.stylix.homeModules.stylix ];

  

  stylix = {
    enable = true;

    targets.nixvim.enable = false;

    image = pkgs.fetchurl {
      url = backgroundUrl;
      sha256 = backgroundSha256;
    };

    base16Scheme = themePath;
    fonts = {
      monospace = {
	name = userSettings.font;
	package = userSettings.fontPkg;
      };

      serif = {
	name = userSettings.font;
	package = userSettings.fontPkg;
      };
      
      sansSerif = {
	name = userSettings.font;
	package = userSettings.fontPkg;
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
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
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
      #monospace = [ userSettings.font ];
      #sansSerif = [ userSettings.font ];
     # serif = [ userSettings.font ];
    #};
    
  };

}
