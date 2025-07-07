{ config, pkgs, userSettings, ... }:

{
  imports = [
    ./user/app/git/git.nix
    ./user/style/stylix.nix
    ./user/app/nixvim/nixvim.nix
  ];

  home.username = userSettings.username;
  home.homeDirectory = "/home/${userSettings.username}";

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    zsh
    syncthing
    libreoffice
    spotify
    discord
    gfn-electron
    teams-for-linux
    adwaita-icon-theme
    zapzap
    nautilus
    vlc
    wine
    xfce.xfconf        # Provides `xfconf-query`
    xfce.xfdesktop  
  ];

  home.file = {
    
  };

  
  home.sessionVariables = {
    EDITOR = userSettings.editor;
    TERM = userSettings.terminal;
    BROWSER = userSettings.browser;
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
