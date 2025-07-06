{ config, pkgs, userSettings, ... }:

{
  imports = [
    ./user/app/git/git.nix
  ];

  home.username = userSettings.username;
  home.homeDirectory = "/home/${userSettings.username}";

  home.stateVersion = "25.05";

  home.packages = [
    
  ];

  home.file = {
    
  };

  
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
