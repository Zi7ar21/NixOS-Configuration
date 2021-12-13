{
  description = "NixOS conf";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nur.url = "github:nix-community/NUR";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nur, home-manager, ... }:
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };

    WorkstationModules = [
      # System related
      ./system/Workstation/hardware-configuration.nix
      ./system/Workstation/boot.nix
      ./system/Workstation/networking.nix
      ./system/Workstation/configuration.nix
      # Common modules  
      ./common/ssd.nix
      ./common/opengl.nix
      ./common/gnome.nix
      ./common/globalPackages.nix
    ];

    lib = nixpkgs.lib;
  in {
    homeConfigurations = {
      nemesis = home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;
        username = "nemesis";
        homeDirectory = "/home/nemesis";
        configuration = {
          imports = [
            ./users/nemesis/home.nix
            { nixpkgs.overlays = [ nur.overlay ]; }
            
          ];
        };
      };
    };
    nixosConfigurations = {
      Workstation = lib.nixosSystem {
        inherit system;
        modules = WorkstationModules ++ [./common/amdgpu.nix];
      };

      Workstation-VFIO = lib.nixosSystem {
        inherit system;
        modules = (WorkstationModules ++ [./system/Workstation/vfio.nix]);
      };
    };
  };
}
