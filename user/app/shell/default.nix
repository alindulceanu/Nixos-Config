{ userSettings, ... }:
let
  aliases = {
    nrs = "sudo nixos-rebuild switch --flake ${userSettings.dotfilesDir}"; 
    hrs = "home-manager switch --flake ${userSettings.dotfilesDir}";
    ".." = "cd ../";
    "...." = "cd ../../";
    "......" = "cd ../../../";
    nvim = "nvim .";
  };
in
{
  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = aliases;

    initExtra = ''
    PROMPT=" ◉ %U%F{magenta}%n%f%u@%U%F{blue}%m%f%u:%F{yellow}%~%f
     %F{green}→%f "
    RPROMPT="%F{red}▂%f%F{yellow}▄%f%F{green}▆%f%F{cyan}█%f%F{blue}▆%f%F{magenta}▄%f%F{white}▂%f"
    [ $TERM = "dumb" ] && unsetopt zle && PS1='$ '
    bindkey '^P' history-beginning-search-backward
    bindkey '^N' history-beginning-search-forward
    '';
  };

  
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = aliases;
  };

  
  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.direnv.nix-direnv.enable = true;
}
