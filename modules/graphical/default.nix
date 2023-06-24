{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./gnome
    ./firefox
  ];

  options.bbommarito.graphical.enable = lib.mkEnableOption "Enable graphical settings";

  config =
    lib.mkIf config.bbommarito.graphical.enable
    {
      bbommarito = {
        graphical.firefox.enable = true;

        user.extraGroups = ["networkmanager"];
      };

      networking = {
        networkmanager = {
          enable = true;
          wifi.backend = "iwd";
        };

        wireless.iwd.settings.Settings.AutoConnect = true;
      };

      services = {
        xserver = {
          libinput = {
            touchpad = {
              disableWhileTyping = true;
              naturalScrolling = true;
              tapping = true;
            };
            enable = true;
          };
        };
      };
    };
}
