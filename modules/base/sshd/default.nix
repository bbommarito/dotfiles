{ config
, lib
, ...
}: {
  options.bbommarito.base.sshd.enable = lib.mkEnableOption "Enable base sshd settings";

  config = lib.mkIf config.bbommarito.base.sshd.enable {
    services.openssh.enable = true;

    age.identityPaths = [
      "${config.etu.dataPrefix}/etc/ssh/ssh_host_ed25519_key"
      "${config.etu.dataPrefix}/etc/ssh/ssh_host_rsa_key"
    ];

    # Persistence of ssh key files
    bbommarito.base.zfs.system.files = [
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
  };
}
