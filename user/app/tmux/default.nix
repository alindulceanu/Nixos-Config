{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    terminal = "xterm-kitty";
    clock24 = true;
    shell = "${pkgs.zsh}/bin/zsh";
    plugins = with pkgs; [
       
    ];
  };
}
