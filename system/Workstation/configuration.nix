{ config, pkgs, ... }:

{
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
  system.stateVersion = "21.11";
}
