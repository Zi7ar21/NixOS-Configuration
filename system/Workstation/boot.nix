
{ config, pkgs, lib, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackagesFor ( pkgs.linux_latest.override {
    structuredExtraConfig = with lib.kernel; {
      MPTCP     =yes;
      MPTCP_IPV6=yes;
    };
  });
  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/b14fceb9-3369-479b-9f42-16e8b55f7861";
    preLVM = true;
    allowDiscards = true;
  };
}