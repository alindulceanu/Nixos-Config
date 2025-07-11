{ pkgs, lib, config, ... }:
{
  options = {
    gitSettings.name = lib.mkOption {
      type = lib.types.str;
      default = "alin";
      description = "sets the name for git";
    };

    gitSettings.email = lib.mkOption {
      type = lib.types.str;
      default = "dummy@dummy.com";
      description = "sets email for git";
    };
  };

  config = {
    home.packages = [ pkgs.git ];
    programs.git = { 
      enable = true;
      userName = config.gitSettings.name;
      userEmail = config.gitSettings.email;
      extraConfig = {
        init.defaultBranch = "main";
        safe.directory = [ ("/home/" + config.gitSettings.name + "/.dotfiles")
                           ("/home/" + config.gitSettings.name + "/.dotfiles/.git") ];
      }; 
    }; 
  };
}
