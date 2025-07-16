{ config, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./../../user
  ];

  gitSettings = {
    name = "alin";
    email = "alin.dulceanu@gmail.com";
  };

  # Stylix
  style = {
    theme = "car";
    font = {
      name = "FiraCode Nerd Font";
      package = pkgs.nerd-fonts.fira-code;
    };
    cursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };
  };

  stylix.enableReleaseChecks = false; 

  waybar.enable = true;

  terminals.kitty.enable = true;

  home.username = "alin";
  home.homeDirectory = "/home/alin";

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    fastfetch
    zsh
    syncthing
    libreoffice
    spotify
    discord
    gfn-electron
    teams-for-linux
    adwaita-icon-theme
    devbox
    zapzap
    vlc
    flameshot
    wineWowPackages.stable
    winetricks
    keepassxc
    keepmenu
    p7zip
    pywal
  ] ++ ( with pkgs-unstable; [
#    wineWowPackages.waylandFull
  ]);

  hypr.enable = true;

  home.file = {
    
  };
  
  home.sessionVariables = {
    EDITOR = "nvim";
    TERM = "kitty";
    BROWSER = "firefox";
  };

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    music = "${config.home.homeDirectory}/Media/Music";
    videos = "${config.home.homeDirectory}/Media/Videos";
    pictures = "${config.home.homeDirectory}/Media/Pictures";
    download = "${config.home.homeDirectory}/Downloads";
    documents = "${config.home.homeDirectory}/Documents";

    desktop = null;
    publicShare = null;

    extraConfig = {
      XDG_DOTFILES_DIR = "${config.home.homeDirectory}/.dotfiles";
      XDG_ARCHIVE_DIR = "${config.home.homeDirectory}/Archive";
      XDG_VM_DIR = "${config.home.homeDirectory}/Machines";
    };
  };

  gtk.iconTheme = {
    package = pkgs.papirus-icon-theme;
    name = if (config.stylix.polarity == "dark") then "Papirus-Dark" else "Papirus-Light";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
