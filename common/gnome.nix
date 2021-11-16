{ config, pkgs, ... }:
{

  programs.dconf.enable = true;
  xdg.portal.enable = true;
  
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = [ pkgs.gnome.cheese pkgs.gnome-photos pkgs.gnome.gnome-music pkgs.gnome.gedit pkgs.epiphany pkgs.evince pkgs.gnome.gnome-characters pkgs.gnome.totem pkgs.gnome.tali pkgs.gnome.iagno pkgs.gnome.hitori pkgs.gnome.atomix pkgs.gnome-tour ];
}