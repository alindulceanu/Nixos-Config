{ config, pkgs, ... }:
let
  layout = import ./layout.nix;
  style = import ./style.nix { inherit config; };
in
{
  home.packages = with pkgs; [
    wlogout
  ];

  programs.wlogout = {
    enable = true;
    
    layout = layout;
    style = style;
  };
}
