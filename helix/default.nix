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
    nodePackages_latest.typescript
    nodePackages_latest.typescript-language-server
    nodePackages_latest.svelte-language-server
    vscode-langservers-extracted
    dockerfile-language-server-nodejs
    nodePackages_latest.bash-language-server

    marksman
    ltex-ls
    tailwindcss-language-server
    taplo
    lua-language-server
    nodePackages_latest.prisma
    yaml-language-server

    # extra go servers installed via go install
    # golangci-lint
    # golangci-lint-langserver
    # gofumpt
  ];
  programs = {
    helix = {
      enable = true;
    };
  };
  xdg.configFile."helix/config.toml".source = ./config/config.toml;
  xdg.configFile."helix/languages.toml".source = ./config/languages.toml;
  xdg.configFile."helix/themes/my-tokyo.toml".source = ./config/my-tokyo.toml;
}
