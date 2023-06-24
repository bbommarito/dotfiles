{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./fish
    ./sshd
  ];

  options.bbommarito = {
    stateVersion = lib.mkOption {
      type = lib.types.str;
      example = "23.05";
      description = "The NixOS state ersion to use for this system";
    };
    dataPrefix = lib.mkOption {
      type = lib.types.str;
      default = "/data";
      description = "The path to where persistent storage happens";
    };
  };

  config = {
    bbommarito.base = {
      fish.enable = lib.mkDefault true;
      sshd.enable = lib.mkDefault true;
    };

    environment.systemPackages = [
      pkgs.alejandra
      pkgs.btop
      pkgs.curl
      pkgs.direnv
      pkgs.dnsutils
      pkgs.host
      pkgs.git
      pkgs.nixpkgs-fmt
      pkgs.whois
      pkgs.vim
    ];

    home-manager.users.${config.bbommarito.user.username} =
      lib.mkIf config.bbommarito.user.enable
      {
        home.stateVersion = config.bbommarito.stateVersion;
      };

    home-manager.users.root.home.stateVersion = config.bbommarito.stateVersion;

    i18n = {
      defaultLocale = "en_US.UTF-8";
      supportedLocales = [
        "all"
      ];
    };

    nix = {
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };

      nixPath = [
        "nixpkgs=${pkgs.path}"
      ];

      settings.experimental-features = ["nix-command" "flakes"];
    };

    nixpkgs.config.allowUnfree = true;

    security.doas.enable = true;

    system.stateVersion = config.bbommarito.stateVersion;

    time.timeZone = "America/Detroit";
  };
}
