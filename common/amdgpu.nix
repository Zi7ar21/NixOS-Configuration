{ config, pkgs, ... }:

{
  boot.initrd.kernelModules = [ "amdgpu" ];

  hardware.opengl.extraPackages = with pkgs; [
     rocm-opencl-icd
     rocm-opencl-runtime
     amdvlk
  ];

  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
}
