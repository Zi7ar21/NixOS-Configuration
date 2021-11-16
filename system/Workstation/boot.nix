
{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/b14fceb9-3369-479b-9f42-16e8b55f7861";
    preLVM = true;
    allowDiscards = true;
  };
}