{
  description = "System flake";

  outputs = inputs@{ self, ... }:
  let
    systemSettings = {
      system = "x86_64-linux";
      isLaptop = false;
      hostname = "home-pc";
      profile = "personal"; # to be implemented
      timezone = "Europe/Bucharest";
      locale = "en_US.UTF-8";
      bootMode = "uefi";
      bootMountPath = "/boot";
      gpuType = "intel";
    };

    userSettings = rec {
      username = "alin";
      name = "Alin";
      email = "alin.dulceanu@gmail.com";
      dotfilesDir = "~/.dotfiles";
      theme = "ashes"; # to be implemented
      themePolarity = "dark";
      wm = "hyprland";
      displayServer = if ((wm == "hyprland") || (wm == "plasma")) then "wayland" else "x11";
      terminal = "kitty";
      font = "FiraCode Nerd Font";
      fontPkg = pkgs-stable.nerd-fonts.fira-code;
      editor = "neovim";
      browser = "firefox";
    };

    pkgs = pkgs-stable;

    pkgs-stable = import inputs.nixpkgs-stable {
      system = systemSettings.system;
      config = {
	allowUnfree = true;
	allowUnfreePredicate = (_: true);
      };
    };

    pkgs-unstable = import inputs.nixpkgs-unstable {
      system = systemSettings.system;
      config = {
	allowUnfree = true;
	allowUnfreePredicate = (_: true);
      }; 
    };

    lib-stable = inputs.nixpkgs-stable.lib;
    lib-unstable = inputs.nixpkgs-unstable.lib;

  in {
    nixosConfigurations = {
      "${userSettings.username}" = lib-stable.nixosSystem {
	system = systemSettings.system;
	modules = [ 
	  ./configuration.nix
	  inputs.stylix.nixosModules.stylix
	];
	specialArgs = {
	  inherit systemSettings;
	  inherit userSettings;
	  inherit pkgs-stable;
	  inherit pkgs-unstable;
	  inherit inputs;
	};
      };
    };

    homeConfigurations = {
      "${userSettings.username}" = inputs.home-manager.lib.homeManagerConfiguration {
	inherit pkgs;
	modules = [
	  ./home.nix
	];
	extraSpecialArgs = {
	  inherit userSettings;
	  inherit pkgs-stable;
	  inherit inputs;
	  inherit systemSettings;
	};
      };
    };
   };
  inputs = {
    nixpkgs-stable.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    stylix.url = "github:danth/stylix/release-25.05";
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };
}

