{
  description = "bbommarito/nixpkgs";

  inputs = {
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    agenix.inputs.home-manager.follows = "home-manager";
    flake-utils.url = "flake-utils";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nur.url = "nur";
  };

  outputs =
    { self
    , flake-utils
    , nixpkgs
    , ...
    } @ inputs:
    let
      myData = import ./data.nix;

      mkSystem =
        { name
        , system ? "x86_64-linux"
        , extraArgs ? { }
        , extraModules ? [ ]
        ,
        }:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        nixpkgs.lib.nixosSystem {
          inherit system;

          modules =
            [
              ./hosts/${name}/configuration.nix
              ./hardware
              ./modules
              inputs.agenix.nixosModules.age
              inputs.home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                }
              inputs.impermanence.nixosModules.impermanence
              inputs.nur.nixosModules.nur
            ]
            ++ extraModules;

          specialArgs = {
            inherit myData;
          };
        };
    in
    {
      nixosConfigurations = {
        mufasa =
          mkSystem
            {
              name = "mufasa";
            };

        nala =
          mkSystem
            {
              name = "nala";
            };
      };

      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) inputs.deploy-rs.lib;
    }
    // flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      formatter = pkgs.alejandra;

      devShells.default = pkgs.mkShell {
        buildInputs = [
          inputs.agenix.packages.${system}.agenix
        ];
      };
    });
}
