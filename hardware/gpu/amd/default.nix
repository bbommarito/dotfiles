{
  config,
  lib,
  pkgs,
  ...
}: {
  options.bbommarito.hardware.gpu.amd.enable = lib.mkEnableOption "Enable AMD GPU";

  config =
    lib.mkIf config.bbommarito.hardware.gpu.amd.enable
    {
      services.xserver.videoDrivers = lib.mkDefault ["modesetting"];

      hardware.opengl = {
        driSupport = true;
        driSupport32Bit = true;
      };

      boot.initrd.kernelModules = ["amdgpu"];

      hardware.opengl.extraPackages = with pkgs; [
        amdvlk
        rocm-opencl-icd
        rocm-opencl-runtime
      ];

      hardware.opengl.extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };
}
