{ pkgs, pkgs-unstable,... }:
let
  aliases = {
    nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles"; 
    hrs = "home-manager switch --flake ~/.dotfiles";
    ".." = "cd ../";
    "...." = "cd ../../";
    "......" = "cd ../../../";
    nvim = "nvim .";
  };
in
{
  programs.zsh = {
    enable = true;
    initContent = ''
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
      fastfetch
      eval "$(direnv hook zsh)"
    '';
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = aliases;
    plugins = [
      {
        name = "powerlevel10k-config";
        src = pkgs.zsh-powerlevel10k;
        file = "p10k.zsh";
      }
      {
        name = "zsh-powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
        file = "powerlevel10k.zsh-theme";
      }
    ];
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "z" "sudo" "command-not-found" ];
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = aliases;
  };
}
