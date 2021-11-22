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
  environment.gnome.excludePackages = [ pkgs.gnome.cheese pkgs.gnome-photos pkgs.gnome.gnome-music pkgs.gnome.gedit pkgs.epiphany pkgs.evince pkgs.gnome.gnome-characters pkgs.gnome.totem pkgs.gnome.tali pkgs.gnome.iagno pkgs.gnome.hitori pkgs.gnome.atomix pkgs.gnome-tour ];
}
