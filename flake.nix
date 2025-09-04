{
  description = "Main Flake";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";

    nix-matlab = {
      url = "path:home/productivity/matlab";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, nix-matlab, ... }: 
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };  
      flake-overlays = [
        nix-matlab.overlay
      ];
    in {
    nixosConfigurations = {
      framework = lib.nixosSystem {
        inherit system;
        modules = [ (import ./hosts/framework/configuration.nix flake-overlays) ]; 
      };
    };
    homeConfigurations = {
      johann = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./home/productivity/home.nix
        ];
      };
    };
  };
}
