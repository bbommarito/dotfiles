{
  config,
  lib,
  pkgs,
  ...
}: {
  options.bbommarito.graphical.firefox = {
    enable = lib.mkEnableOption "Enable graphical firefox settings";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.firefox;
      description = "Firefox package to use.";
      readOnly = true;
    };
  };

  config = lib.mkIf config.bbommarito.graphical.firefox.enable {
    home-manager.users.${config.bbommarito.user.username} = lib.mkIf config.bbommarito.user.enable {
      programs.firefox = {
        enable = true;
        package = config.bbommarito.graphical.firefox.package;

        profiles.default = {
          extensions = [
            config.nur.repos.rycee.firefox-addons.onepassword-password-manager
          ];
        };
      };
    };
  };
}
