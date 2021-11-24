{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../common/ssd.nix
      ../../common/virt.nix
#      ../../common/security.nix
      ./boot.nix
      ./networking.nix
    ];

  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  time.timeZone = "Europe/Berlin";
 
  services.openssh.enable = true;
  
  users.users.nemesis = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; 
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDelmomLMC1bm7Mrj+lGdOzRm03AXkpSLooZzFw9E26F openpgp:0xDEFDEF59"
    ];
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

  system.stateVersion = "21.05";
}
