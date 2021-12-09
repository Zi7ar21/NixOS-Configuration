{ config, pkgs, ... }:

{
  boot.kernelParams = [ "amd_iommu=on" "video=efifb:off" "msr.allow_writes=on" ];
  boot.blacklistedKernelModules = [ "amdgpu" "radeon" ];
  boot.kernelModules = [  "vendor-reset" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" "msr" ];
  boot.extraModprobeConfig = "options vfio-pci ids=1002:67df,1002:aaf0";
  boot.extraModulePackages = with config.boot.kernelPackages; [ vendor-reset ];

  services.udev.extraRules = ''
    SUBSYSTEM=="vfio", OWNER="root", GROUP="kvm"
    SUBSYSTEM=="usb", OWNER="root", GROUP="kvm"
  '';

  security.pam.loginLimits = [
    { domain = "nemesis"; item = "memlock"; type = "-"; value = "unlimited"; }
  ];
}
