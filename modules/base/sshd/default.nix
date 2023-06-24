{
  config,
  lib,
  ...
}: {
  options.bbommarito.base.sshd.enable = lib.mkEnableOption "Enable base sshd settings";

  config = lib.mkIf config.bbommarito.base.sshd.enable {
    services.openssh.enable = true;
  };
}
