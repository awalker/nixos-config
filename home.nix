{ config
, lib
, pkgs
, user
, ...
}: {
  imports = [ (import ./neovim) ]
    ++ [ (import ./helix) ];
  # ++ [ (import ../modules/dev/git) ]
  # ++ [ (import ../modules/dev/kitty) ]
  # ++ [ (import ../modules/dev/starship) ]
  # ++ [ (import ../modules/dev/tmux) ]
  # ++ [ (import ../modules/dev/zsh) ]
  # ++ [ (import ../modules/desktop/bspwm) ]
  # ++ [ (import ../modules/desktop/sxhkd) ]
  # ++ [ (import ../modules/desktop/polybar) ]
  # ++ [ (import ../modules/desktop/rofi) ]
  # ++ [ (import ../modules/desktop/picom) ]
  # ++ [ (import ../modules/desktop/dunst) ]
  # ++ [ (import ../modules/desktop/betterlockscreen) ]
  # ++ [ (import ../modules/apps/firefox) ];

  programs.home-manager.enable = true;
  # xdg.configFile."wallpapers".source = ../assets/wallpapers;
  # xdg.configFile."bin".source = ../dots/bin;

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    sessionPath = [ "/home/${user}/.config/bin" ];

    packages = with pkgs; [
      home-manager
      nano
      firefox
      vivaldi
      authy
      kate
      _1password-gui
      _1password
      syncthing
      wezterm
      bluetuith
      steam
      steam-run
      wlsunset
      freshfetch
      starship
      networkmanagerapplet
      networkmanager_dmenu
      grim
      grimblast
      imv
      xfce.thunar
      ydotool
      eww
      taskwarrior
      tasksh
      tunnelto
      obsidian
      spotifyd
      godot_4
      glow
      gum
      git-cliff
      just
      watchexec
      spotify
      gh
      git-sync
      msmtp
    ];
    stateVersion = "23.05";
  };
}
