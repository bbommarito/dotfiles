{lib, ...}:
with lib.hm.gvariant; {
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/desktop/periphals/touchpad" = {
      tap-to-click = true;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/screensaver" = {
      lock-delay = mkUint32 1800;
      lock-enabled = "true";
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 900;
    };

    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
    };

    "org/gnome/shell" = {
      enabled-extensions = ["appindicatorsupport@rgcjonas.gmail.com"];
    };
    "org/gnome/mutter" = {
      experimental-features = ["scale-monitor-framebuffer"];
    };
    "org/gnome/terminal/legacy/profiles:/:b7982be9-c1f9-43c9-ae8f-f47558f2c5ca" = {
      background-color = "#0b0d0f";
      bold-color = "#ffffff";
      bold-color-same-as-fg = true;
      font = "ComicCodeLigatures Nerd Font 16";
      foreground-color = "#ffffff";
      palette = ["#414d58" "#ff9580" "#8aff80" "#ffff80" "#9580ff" "#ff80bf" "#80ffea" "#f8f8f2" "#4c5967" "#ffaa99" "#a2ff99" "#ffff99" "#aa99ff" "#ff99cc" "#99ffee" "#ffffff"];
      use-system-font = false;
      use-theme-background = false;
      use-theme-colors = false;
      visible-name = "General";
    };
    "org/gnome/terminal/legacy/profiles:" = {
      default = "b7982be9-c1f9-43c9-ae8f-f47558f2c5ca";
      list = ["b7982be9-c1f9-43c9-ae8f-f47558f2c5ca"];
    };
  };
}
