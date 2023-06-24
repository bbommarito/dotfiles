{ config
, lib
, myData
, pkgs
, ...
}: {
  imports =
    [
      ./vscode
    ];

  options.bbommarito.development.enable = lib.mkEnableOption "Enable development settings";

  config = lib.mkIf config.bbommarito.development.enable
    {
      environment.systemPackages = with pkgs; [ gnupg ];

      programs.ssh.startAgent = false;

      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };

      services.pcscd.enable = true;

      home-manager.users.${config.bbommarito.user.username} = lib.mkIf config.bbommarito.user.enable {
        programs = {
          fish.shellInit =
            ''
              set --global --export KEYID ${config.bbommarito.user.signingKey}
              set --global --export GPG_TTY (tty)
              set --global --export SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
              gpgconf --launch gpg-agent
            '';

          git = {
            enable = true;
            signing = {
              key = "${config.bbommarito.user.signingKey}";
              signByDefault = true;
            };
            userEmail = "${config.bbommarito.user.email}";
            userName = "${config.bbommarito.user.realname}";
          };

          gpg = {
            enable = true;

            publicKeys = [
              {
                source = ./gpg.pub;
                trust = 5;
              }
            ];
          };
        };
      };
    };
}
