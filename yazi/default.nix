{
  #config, 
  pkgs
, # mrc,
  ...
}: {
  # home.packages = with pkgs; [
  # ];
  programs = {
    yazi = {
      enable = true;
      enableFishIntegration = true;
    };
  };
  # xdg.configFile."yazi/yazi.toml".source = ./config/yazi.toml;
  xdg.configFile."yazi/keymap.toml".source = ./config/keymap.toml;
  xdg.configFile."yazi/theme.toml".source = ./config/theme.toml;
}
