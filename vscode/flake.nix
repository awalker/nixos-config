{
  description = "Home Manager configuration of kon";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs = { nixpkgs, home-manager, vscode-server, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."kon" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home.nix
          vscode-server.nixosModules.default  # I'm trying to specify the vscode-server "module" here, but this doesn't seem to work.
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}

