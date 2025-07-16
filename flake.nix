{
  description = "System flake";

  outputs = inputs@{ self, ... }:
  let
    pkgs = pkgs-stable;

    pkgs-stable = import inputs.nixpkgs-stable {
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
      };
    };

    pkgs-unstable = import inputs.nixpkgs-unstable {
      system = "x86_64-linux";
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
        system = "x86_64-linux";
        modules = [ 
          ./hosts/home-pc/configuration.nix
          inputs.stylix.nixosModules.stylix
        ];
        specialArgs = {
          inherit pkgs-stable;
          inherit pkgs-unstable;
          inherit inputs;
        };
      };
      laptop = lib-stable.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          ./hosts/laptop/configuration.nix
          inputs.stylix.nixosModules.stylix
        ];
        specialArgs = {
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
          inherit inputs;
          inherit pkgs-unstable;
        };
      };
      aln = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./hosts/laptop/home.nix
        ];
        extraSpecialArgs = {
          inherit pkgs-stable;
          inherit inputs;
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
    stylix = {
      url = "github:alindulceanu/stylix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
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

