{
  config,
  lib,
  ...
}: {
  options.bbommarito.hardware.cpu.intel.enable = lib.mkEnableOption "Enable Intel CPU";

  config =
    lib.mkIf config.bbommarito.hardware.cpu.intel.enable
    {
      hardware.cpu.intel.updateMicrocode =
        lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
