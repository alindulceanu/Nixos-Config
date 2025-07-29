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
    theme = "space1";
    font = {
      name = "FiraCode Nerd Font";
      package = pkgs.nerd-fonts.fira-code;
    };
    cursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };
  };

  dev.enable = true;
  stylix.enableReleaseChecks = false; 
  waybar.enable = true;
  terminals.kitty.enable = true;

  hypr = {
    enable = true;
    monitor = {
      name = "DP-1";
      resolution = "1920x1080";
      frequency = "75";
    };
    naturalScroll = false;
  };

  home.username = "alin";
  home.homeDirectory = "/home/alin";

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    fastfetch
    syncthing
    libreoffice
    kdePackages.okular
    gimp
    spotify
    discord
    gfn-electron
    teams-for-linux
    adwaita-icon-theme
    obs-studio
    devbox
    zapzap
    vlc
    wineWowPackages.stable
    winetricks
    keepassxc
    keepmenu
    p7zip
    fd
    pywal
  ] ++ ( with pkgs-unstable; [
#    wineWowPackages.waylandFull
  ]);

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
      XDG_CODE_DIR = "${config.home.homeDirectory}/Code";
    };
  };

  xdg.mimeApps = {
    enable = true;

    associations.added = {
      "text/plain" = [ "firefox.desktop" ];
      "text/html" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "application/pdf" = [ "org.kde.okular.desktop" "firefox.desktop" ];
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [ "writer.desktop" ];
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = [ "calc.desktop" ];
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" = [ "impress.desktop" ];
    };

    defaultApplications = {
      "text/plain" = [ "firefox.desktop" ];
      "text/html" = [ "firefox.desktop" ];
      "video/mp4" = [ "vlc.desktop" ];
      "video/x-matroska" = [ "vlc.desktop" ];
      "video/webm" = [ "vlc.desktop" ];
      "video/x-msvideo" = [ "vlc.desktop" ];
      "video/x-ms-wmv" = [ "vlc.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "application/pdf" = [ "firefox.desktop" ]; 
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [ "writer.desktop" ];
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = [ "calc.desktop" ];
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" = [ "impress.desktop" ];
    };
  };

  gtk.iconTheme = {
    package = pkgs.papirus-icon-theme;
    name = if (config.stylix.polarity == "dark") then "Papirus-Dark" else "Papirus-Light";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
