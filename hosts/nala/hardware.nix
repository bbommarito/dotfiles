{ config
, lib
, pkgs
, modulesPath
, ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  bbommarito.hardware.cpu.intel.enable = true;
  bbommarito.hardware.gpu.intel.enable = true;

  boot = {
    extraModulePackages = [ ];

    initrd = {
      availableKernelModules =
        [
          "xhci_pci"
          "thunderbolt"
          "nvme"
          "usb_storage"
          "usbhid"
          "sd_mod"
        ];

      kernelModules =
        [ ];

      luks =
        {
          devices =
            {
              zlocal =
                {
                  allowDiscards = true;
                  device = "/dev/disk/by-uuid/844f1abd-65ae-4b2c-8de9-d3f715428832";
                  preLVM = true;
                };

              zsafe =
                {
                  allowDiscards = true;
                  device = "/dev/disk/by-uuid/a08ec7db-9670-4c70-a0ed-18460dae1b3b";
                  preLVM = true;
                };
            };
        };
    };

    kernelModules = [ "kvm-intel" ];

    kernelPackages = pkgs.zfs.latestCompatibleLinuxPackages;

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        configurationLimit = 5;

        enable = true;
      };
    };
  };

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "defaults" "size=3G" "mode=755" ];
  };

  fileSystems."/nix" =
    {
      device = "zlocal/root/nix";
      fsType = "zfs";
      neededForBoot = true;
    };

  fileSystems."/var/log" =
    {
      device = "zlocal/root/var-log";
      fsType = "zfs";
      neededForBoot = true;
      options = [ "defaults" "noexec" ];
    };

  fileSystems.${config.bbommarito.dataPrefix} = {
    device = "zsafe/root/data";
    fsType = "zfs";
    neededForBoot = true;
    options = [ "defaults" "noexec" ];
  };

  fileSystems."${config.bbommarito.dataPrefix}/home" = {
    device = "zsafe/safe/home";
    fsType = "zfs";
    neededForBoot = true;
    options = [ "defaults" "noexec" ];
  };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/BA41-9ACC";
      fsType = "vfat";
      options = [ "defaults" "noexec" "noauto" "x-systemd.automount" ];
    };

  networking = {
    hostName = "nala";
    hostId = "58632ebd";
  };

  nix.settings.max-jobs = lib.mkDefault 12;
}
