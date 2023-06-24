{
  config,
  lib,
  myData,
  pkgs,
  ...
}: {
  config =
    lib.mkIf (config.bbommarito.development.enable && config.bbommarito.graphical.enable)
    {
      home-manager.users.${config.bbommarito.user.username} =
        lib.mkIf config.bbommarito.user.enable
        {
          programs = {
            vscode = {
              enable = true;
              enableExtensionUpdateCheck = false;
              enableUpdateCheck = false;
              extensions = with pkgs.vscode-extensions; [
                kamadorueda.alejandra
                jnoortheen.nix-ide
                bbenoist.nix
                vscodevim.vim
              ];
            };
          };
        };
    };
}
