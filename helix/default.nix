{
  #config, 
  pkgs
, # mrc,
  ...
}: {
  home.packages = with pkgs; [
    # lsps and such
    # nix
    nil
    nixpkgs-fmt

    # js/ts etc
    nodePackages_latest.typescript-language-server
    nodePackages_latest.svelte-language-server

    # extra go servers installed via go install
    # golangci-lint
    # golangci-lint-langserver
    # gofumpt
  ];
  programs = {
    helix = {
      plugins = [
        # pkgs.vimPlugins.nvim-treesitter
      ];
      # extraConfig = ''
      #           lua << EOF
      #           ${builtins.readFile config/config.toml}
      #           ${builtins.readFile config/languages.toml}
      # '';
      enable = true;
      xdg.configFile."helix/config.toml".source = ./config/config.toml;
      xdg.configFile."helix/languages.toml".source = ./config/languages.toml;
    };
  };
}
