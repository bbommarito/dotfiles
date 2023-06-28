{ config
, lib
, ...
}: {
  options.bbommarito.base.zfs =
    let
      option = param: {
        directories = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          description = "Directories to pass to environment.persistence attribute for ${param} under ${config.etu.dataPrefix}";
        };
        files = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          description = "Files to pass to environment.persistence attribute for ${param} under ${config.etu.dataPrefix}";
        };
      };
    in
    {
      enable = lib.mkEnableOption "Enable base zfs persistence settings";
      system = options "system";
      user = options "user";
      root = options "root";
    };
  config = lib.mkIf config.etu.base.zfs.enable {
    environment.persistence.${config.bbommarito.dataPrefix} = {
      directories = config.bbommarito.base.zfs.system.directories;
      files =
        [
          "/etc/machine-id"
        ]
        ++ config.bbommarito.base.zfs.system.files;
      users.root = {
        home = config.users.users.root.home;
        directories = config.bbommarito.base.zfs.root.directories;
        files = config.bbommarito.base.zfs.root.files;
      };
      users.${config.etu.user.username} = lib.mkIf config.bbommarito.user.enable {
        directories = config.bbommarito.base.zfs.user.directories;
        files = config.bbommarito.base.zfs.user.files;
      };
    };
  };
}
