{
  config,
  lib,
  myData,
  pkgs,
  ...
}: {
  options.bbommarito.user = {
    enable = lib.mkEnableOption "Enables my user";
    uid =
      lib.mkOption
      {
        type = lib.types.nullOr lib.types.int;
        default = 1000;
        description = "My user id for this system.";
      };
    username =
      lib.mkOption
      {
        type = lib.types.str;
        default = "bbommarito";
        description = "My username for this system.";
      };
    realname =
      lib.mkOption
      {
        type = lib.types.str;
        default = "Brian \"Burrito\" Bommarito";
        description = "My realname for this system.";
      };
    email =
      lib.mkOption
      {
        type = lib.types.str;
        default = "brian@brianbommarito.xyz";
        description = "My email for this system.";
      };
    signingKey = lib.mkOption {
      type = lib.types.str;
      default = "675F2E6CBA45FC655AAA65C508344FF6D0E3107F";
      description = "My public signing key for this system.";
    };
    extraGroups = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
    };
    extraAuthorizedKeys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Additional authorized keys.";
    };
    extraUserPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Extra packages to install in my users profile.";
    };
  };

  config = {
    age.secrets.hashed-bbommarito-password = lib.mkIf config.bbommarito.user.enable myData.ageModules.hashed-bbommarito-password;
    environment.homeBinInPath = config.bbommarito.user.enable;

    users.mutableUsers = false;

    users.users.${config.bbommarito.user.username} =
      lib.mkIf config.bbommarito.user.enable
      {
        description = "${config.bbommarito.user.realname},,,,";
        extraGroups = ["wheel"];
        isNormalUser = true;
        passwordFile = config.age.secrets.hashed-bbommarito-password.path;
        uid = config.bbommarito.user.uid;
      };
  };
}
