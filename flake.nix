{
  description = "System flake";

  outputs = inputs@{ self, ... }:
  let
    systemSettings = {
      system = "x86_64-linux";
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
      theme = ""; # to be implemented
      wm = "hyprland";
      displayServer = if ((wm == "hyprland") || (wm == "plasma")) then "wayland" else "x11";
      terminal = "alacritty";
      font = "Intel One Mono";
      fontPkg = pkgs-stable.intel-one-mono;
      editor = "neovim";
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
      home-pc = lib-stable.nixosSystem {
	system = systemSettings.system;
	modules = [ ./configuration.nix ];
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
      alin = inputs.home-manager.lib.homeManagerConfiguration {
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
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-stable";
  };
}

