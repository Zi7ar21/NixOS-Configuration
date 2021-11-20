{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../common/ssd.nix
      #./vfio.nix # Only enabled when I need a Windows VM. Comment out amdgpu.nix if enabled.
      ../../common/amdgpu.nix
      ../../common/gnome.nix
      ../../common/virt.nix
      ../../common/globalPackages.nix
#      ../../common/security.nix
      ./boot.nix
      ./networking.nix
    ];

  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  time.timeZone = "Asia/Baghdad";
 
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

#  services.openssh.enable = true;
  
  users.users.nemesis = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "kvm"]; 
  };

  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraRules = [{
      users = [ "nemesis" ];
      persist = true;
      keepEnv = true;
    }];
  };

  hardware.pulseaudio.enable = false;
  system.stateVersion = "21.05";
}
