{
  description = "NixOS conf";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.11";
    nixpkgsUnstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-21.11";
    nur.url = "github:nix-community/NUR";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgsUnstable, nur, home-manager, ... }:
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
    overlay-unstable = final: prev: {
      unstable = nixpkgsUnstable.legacyPackages.x86_64-linux;
    };    
    lib = nixpkgs.lib;
  in {
    homeConfigurations = {
      nemesis = home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;
        username = "nemesis";
        homeDirectory = "/home/nemesis";
        stateVersion = "21.11";
        configuration = {
          imports = [
            ./users/nemesis/home.nix
            { nixpkgs.overlays = [ nur.overlay overlay-unstable ]; }
            
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

      Serverinet = lib.nixosSystem {
        inherit system;
        modules = [
          ./system/Serverinet/configuration.nix
        ];
      };      
    };
  };
}
