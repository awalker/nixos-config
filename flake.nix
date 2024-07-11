# /etc/nixos/flake.nix
{
  description = "flake for odin";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs = { self, nixpkgs, home-manager, vscode-server }:
    let
      user = "walke";
    in
    {
      nixosConfigurations = {
        odin = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit user; };
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            # vscode-server.homeModules.default
            vscode-server.nixosModules.home
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit user;
              };
              home-manager.users.${user} = {
                imports = [
                  (import ./home.nix)
                ];
              };
            }
          ];
        };
      };
    };
}

