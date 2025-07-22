{ pkgs, pkgs-unstable,... }:
let
  aliases = {
    nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles"; 
    nrb = "sudo nixos-rebuild boot --flake ~/.dotfiles";
    hrs = "home-manager switch --flake ~/.dotfiles";
    ".." = "cd ../";
    "...." = "cd ../../";
    "......" = "cd ../../../";
    nvim = "nvim .";
  };
in
{
  home.packages = with pkgs; [
    starship
    zsh
  ];

  programs.starship = {
    enable = true;
    
    settings = {
      add_newline = false;
      scan_timeout = 10;
      format = "$directory$git_branch$git_status$fill$python$nix$nodejs$go$cmd_duration$line_break$character";
      character = {
        success_symbol = "[](bold green) ";
        error_symbol = "[✗](bold red) ";
      };
      fill.symbol = " ";
    };
  };

  programs.bat = {
    enable = true;
    config = {
      style = "numbers,changes,header";
    };
  };

  programs.zsh = {
    enable = true;
    initContent = ''
      fastfetch
      eval "$(direnv hook zsh)"
      eval "$(starship init zsh)"
    '';
    shellAliases = aliases;

    plugins = [
      {
        name = "zsh-autosuggestions";
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
        src = pkgs.zsh-autosuggestions;
      }
      {
        name = "zsh-syntax-highlighting";
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
        src = pkgs.zsh-syntax-highlighting;
      }
      {
        name = "zsh-z";
        file = "share/zsh-z/zsh-z.plugin.zsh";
        src = pkgs.zsh-z;
      }
    ];
  };

  programs.bash = {
    enable = true;
    shellAliases = aliases;
  };
}
