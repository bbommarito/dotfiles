{ config, lib, pkgs, ... }:

{
  options.bbommarito.hardware.gpu.intel.enable = lib.mkEnableOption "Enable Intel GPU";

  config = lib.mkIf config.bbommarito.hardware.gpu.amd.enable
    {
      boot.initrd.kernelModules = [ "i915" ];

      environment.variables = {
        VDPAU_DRIVER = lib.mkIf config.hardware.opengl.enable (lib.mkDefault "va_gl");
      };

      hardware.opengl.extraPackages = with pkgs; [
        vaapiIntel
        libvdpau-va-gl
        intel-media-driver
      ];
    };
}
