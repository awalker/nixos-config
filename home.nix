{ config
, lib
, pkgs
, user
, ...
}: {
  imports = [ (import ./neovim) ]
    ++ [ (import ./helix) ]
    ++ [ (import ./yazi) ];
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

  gtk.enable = true;
  gtk.font.name = "Noto Sans";
  gtk.font.package = pkgs.noto-fonts;
  # gtk.theme.name = "Dracula";
  # gtk.theme.package = pkgs.dracula-theme;
  gtk.theme.package = pkgs.gnome.gnome-themes-extra;
  gtk.theme.name = "Adwaita-dark";
  gtk.iconTheme.name = "Papirus-Dark-Maia"; # Candy and Tela also look good
  gtk.iconTheme.package = pkgs.papirus-maia-icon-theme;
  gtk.gtk3.extraConfig = {
    gtk-application-prefer-dark-theme = true;
    # gtk-key-theme-name    = "Emacs";
    gtk-icon-theme-name = "Papirus-Dark-Maia";
    gtk-cursor-theme-name = "capitaine-cursors";
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      #   gtk-key-theme = "Emacs";
      cursor-theme = "Capitaine Cursors";
    };
  };
  xdg.systemDirs.data = [
    "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
    "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
  ];


  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    sessionPath = [ "/home/${user}/.config/bin" ];

    packages = with pkgs; [
      home-manager
      dconf
      nano
      firefox
      vivaldi
      authy
      kate
      _1password-gui
      _1password
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
      # obsidian
      spotifyd
      godot_4
      glow
      gum
      catppuccin-gtk
      git-cliff
      just
      watchexec
      spotify
      gh
      git-sync
      msmtp
      zls
      udiskie
      # odin
      # ols
      prusa-slicer
      vit
      todo-txt-cli
      socat
      pulsemixer
      wezterm
      river
      wob
      avizo
      unar
      ironbar
      orca-slicer
      mpv
      capitaine-cursors
      gleam
      prismlauncher
      (pkgs.runCommandLocal "capitaine-cursors-fix" { } ''
        dir=$out/share/icons
        mkdir -p $dir
        ln -s ${capitaine-cursors}/share/icons/capitaine-cursors-white $dir/default
      '')
      lm_sensors
    ];
    stateVersion = "23.05";
  };
}
