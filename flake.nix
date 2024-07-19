# /etc/nixos/flake.nix
{
  description = "flake for odin";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nixpkgs-stable = {
      url = "github:NixOS/nixpkgs/nixos-24.05";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };
  # inputs.nix-alien.url = "github:thiagokokada/nix-alien";

  outputs = { self, nixpkgs, home-manager, vscode-server, nixpkgs-stable }:
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
            vscode-server.nixosModules.default
            ({ config, pkgs, ... }: {
              services.vscode-server.enable = true;
            })
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit user;
                system = "x86_64-linux";
                pkgs-stable = import nixpkgs-stable {
                  system = "x86_64-linux";
                  config.allowUnfree = true;
                  # inherit system;
                };
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

