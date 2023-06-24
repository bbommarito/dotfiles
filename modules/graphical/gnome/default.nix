{
  config,
  lib,
  pkgs,
  ...
}: {
  options.bbommarito.graphical.gnome.enable = lib.mkEnableOption "Enable Gnome desktop environment";

  config = lib.mkIf config.bbommarito.graphical.gnome.enable {
    bbommarito.graphical.enable = true;

    environment = {
      gnome.excludePackages =
        (with pkgs; [
          epiphany
          gnome-console
          gnome-photos
          gnome-tour
        ])
        ++ (with pkgs.gnome; [
          atomix
          cheese
          gnome-music
          geary
          hitori
          iagno
          totem
        ]);

      systemPackages =
        (with pkgs.gnome; [
          gnome-terminal
          gnome-tweaks
        ])
        ++ (with pkgs.gnomeExtensions; [
          appindicator
          dash-to-dock
          vertical-workspaces
        ]);
    };

    home-manager.users.${config.bbommarito.user.username} = lib.mkIf config.bbommarito.graphical.gnome.enable {
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
        "org/gnome/desktop/session" = {
          idle-delay = "unit32 900";
        };
        "org/gnome/desktop/screensaver" = {
          lock-delay = "uint32 1800";
          lock-enabled = "true";
        };
        "org/gnome/desktop/peripherals/touchpad" = {
          tap-to-click = "true";
        };
        "org/gnome/settings-daemon/plugins/power" = {
          sleep-inactive-ac-type = "'nothing'";
        };
      };
    };

    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}
