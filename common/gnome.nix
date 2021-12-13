{ config, lib, pkgs, ... }:
{

  services.gvfs = {
    enable = true;
    package = pkgs.gnome3.gvfs;
  };

  programs.dconf.enable = true;
  xdg.portal.enable = true;
  
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome.gnome-keyring.enable = lib.mkForce false;
  security.pam.services.lightdm.enableGnomeKeyring = false;
  programs.ssh.startAgent = true;
  services.gnome.core-utilities.enable = false;
  environment.systemPackages = with pkgs; [
    gnome3.gnome-tweaks
    gnome3.gnome-screenshot
  ];
}
