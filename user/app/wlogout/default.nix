{ pkgs, ... }:
let
  layout = import ./layout.nix;
  style = import ./style.nix;
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
