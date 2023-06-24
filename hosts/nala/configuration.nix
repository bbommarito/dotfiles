{ config
, pkgs
, ...
}: {
  imports = [
    ./hardware.nix
  ];

  bbommarito = {
    stateVersion = "23.05";

    development.enable = true;
    graphical.gnome.enable = true;
    user.enable = true;
  };
}
