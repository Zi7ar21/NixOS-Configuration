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
          # System related
          ./system/Workstation/hardware-configuration.nix
          ./system/Workstation/boot.nix
          ./system/Workstation/networking.nix
          ./system/Workstation/vfio.nix # Only enabled when I need a Windows VM. Comment out amdgpu.nix if enabled.      
          ./system/Workstation/configuration.nix
          
          # Common modules  
          ./common/ssd.nix
          ./common/opengl.nix
         #./common/amdgpu.nix
          ./common/gnome.nix
          ./common/virt.nix
          ./common/globalPackages.nix
        ];
      };   
    };
  };
}
