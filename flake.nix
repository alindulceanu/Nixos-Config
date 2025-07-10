{
  description = "System flake";

  outputs = inputs@{ self, ... }:
  let
    systemSettings = {
      system = "x86_64-linux";
      isLaptop = false;
      profile = "personal"; # to be implemented
      timezone = "Europe/Bucharest";
      locale = "en_US.UTF-8";
      bootMode = "uefi";
      bootMountPath = "/boot";
      gpuType = "intel";
    };

    userSettings = rec {
      name = "Alin";
      email = "alin.dulceanu@gmail.com";
      dotfilesDir = "~/.dotfiles";
      theme = "ashes"; # to be implemented
      themePolarity = "dark";
      wm = "cosmic";
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
      home-pc = lib-stable.nixosSystem {
        system = systemSettings.system;
        modules = [ 
          ./hosts/home-pc/configuration.nix
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
      laptop = lib-stable.nixosSystem {
        system = systemSettings.system;
        modules = [ 
          ./hosts/laptop/configuration.nix
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
      alin = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./hosts/home-pc/home.nix
        ];
        extraSpecialArgs = {
          inherit userSettings;
          inherit pkgs-stable;
          inherit inputs;
          inherit systemSettings;
        };
      };
      aln = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./hosts/laptop/home.nix
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
    firefox-extensions = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };
}

