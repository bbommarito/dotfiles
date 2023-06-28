{ config
, lib
, pkgs
, ...
}:
let
  base = {
    programs.fish.enable = true;

    programs.fish.shellAbbrs = {
      develop = "nix develop $HOME/.dotfiles";
      rebuild = "doas nixos-rebuild switch --flake $HOME/.dotfiles/#";
    };
  };
in
{
  options.bbommarito.base.fish.enable = lib.mkEnableOption "Enable base fish settings";

  config =
    lib.mkIf config.bbommarito.base.fish.enable
      {
        programs.fish.enable = true;

        users.users.${config.bbommarito.user.username} =
          lib.mkIf config.bbommarito.user.enable
            {
              shell = pkgs.fish;
            };

        users.users.root.shell = pkgs.fish;

        home-manager.users.${config.bbommarito.user.username} = lib.mkIf config.bbommarito.user.enable base;

        home-manager.users.root = base;

        bbommarito.base.zfs.user.directories = [
          ".config/fish"
          ".local/share/fish"
        ];

      };
}
