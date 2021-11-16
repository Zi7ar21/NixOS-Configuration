{
  description = "NixOS conf";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.05";
    home-manager.url = "github:nix-community/home-manager/release-21.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let 
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
    };
    lib = nixpkgs.lib;

  in {
    homeConfigurations = {
      nemesis = home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;
        username = "nemesis";
        homeDirectory = "/home/nemesis";
        stateVersion = "21.05";
        configuration = {
          imports = [
            ./users/nemesis/home.nix
          ];
        };
      };
    };
        
    nixosConfigurations = {
      Workstation = lib.nixosSystem {
        inherit system;
        modules = [
          ./system/Workstation/configuration.nix
        ];
      };
    };
  };
}
