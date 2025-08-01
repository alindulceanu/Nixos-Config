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

  in {
    nixosConfigurations = {
      home-pc = inputs.nixpkgs-stable.lib.nixosSystem {
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
      laptop = inputs.nixpkgs-stable.lib.nixosSystem {
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
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
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

