{ config
, lib
, pkgs
, pkgs-stable
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
  # programs.orca-slicer = {
  #   enable = true;
  #   package = pkgs-stable.orca-slicer;
  # };

  # services.vscode-server.enable = true;
  # security.pam.sshAgentAuth.enable = true;
  # xdg.configFile."wallpapers".source = ../assets/wallpapers;
  # xdg.configFile."bin".source = ../dots/bin;

  programs = {
    vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };
    direnv = {
      enable = true;
      #     enableBashIntegration = true;
      nix-direnv.enable = true;
    };
    #   bash.enable = true;
    eza = {
      enableFishIntegration = true;
      enable = true;
    };
    starship = {
      enable = true;
      enableFishIntegration = true;
    };
    fzf.enableFishIntegration = true;
    zoxide = {
      enableFishIntegration = true;
      enable = true;
    };
    zellij.enableFishIntegration = true;
    fish = {
      enable = true;
      shellAbbrs = {
        tunto = "tunnelto -s adamwalker -v --dashboard-port 3001 --host 127.0.0.1 -p 8090";
      };
      shellInit = ''
        set -gx PATH "$HOME/.local/bin" "$HOME/go/bin" $PATH
        set -gx EDITOR hx
        function fish_greeting
            fastfetch
        end

        set -Ux SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent

        # if not pgrep --full ssh-agent | string collect >/dev/null
            # set -e SSH_AGENT_PID
            # set -e SSH_AUTH_SOCK
            # eval (ssh-agent -c)
            # set -Ux SSH_AGENT_PID $SSH_AGENT_PID
            # set -Ux SSH_AUTH_SOCK $XDG_RUNTIME_DIR/gcr/ssh
        # end

      '';
      plugins = [
        {
          name = "jorgebucaran/fisher";
          src = pkgs.fetchFromGitHub {
            owner = "jorgebucaran";
            repo = "fisher";
            rev = "2efd33ccd0777ece3f58895a093f32932bd377b6";
            sha256 = "lnfq4A0Rjzc8KLmyrWNSJZsJaGAFUrLJ3q/NlvRLD1U=";
          };
        }
        {
          name = "TSFoster/posix-source";
          src = pkgs.fetchFromGitHub {
            owner = "TSFoster";
            repo = "posix-source";
            rev = "ae6703fc5abb8aee154d77b67c0408375690bcaf";
            sha256 = "lnfq4A0Rjzc8KLmyrWNSJZsJaGAFUrLJ3q/NlvRLD1U=";
          };
        }
        {
          name = "danhper/fish-ssh-agent";
          src = pkgs.fetchFromGitHub {
            owner = "danhper";
            repo = "fish-ssh-agent";
            rev = "fd70a2afdd03caf9bf609746bf6b993b9e83be57";
            sha256 = "e94Sd1GSUAxwLVVo5yR6msq0jZLOn2m+JZJ6mvwQdLs=";
          };
        }

      ];
    };
  };

  gtk.enable = true;
  gtk.font.name = "Noto Sans";
  gtk.font.package = pkgs.noto-fonts;
  # gtk.theme.name = "Dracula";
  # gtk.theme.package = pkgs.dracula-theme;
  gtk.theme.package = pkgs.gnome-themes-extra;
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

    # home.files.".config/fish" = {
    #   source = ./fish;
    #   recursive = true;
    # };


    packages = with pkgs; [
      home-manager
      # self.inputs.nix-alien.packager.${systen}.nix-alien
      dconf
      nano
      firefox
      vivaldi
      kate
      _1password-gui
      _1password
      bluetuith
      steam
      steam-run
      libgcc.lib
      wlsunset
      fastfetch
      starship
      networkmanagerapplet
      networkmanager_dmenu
      grim
      grimblast
      imv
      xfce.thunar
      ydotool
      eww
      taskwarrior3
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
      # ironbar
      orca-slicer
      # pkgs-stable.orca-slicer
      mpv
      capitaine-cursors
      gleam
      erlang
      prismlauncher
      (pkgs.runCommandLocal "capitaine-cursors-fix" { } ''
        dir=$out/share/icons
        mkdir -p $dir
        ln -s ${capitaine-cursors}/share/icons/capitaine-cursors-white $dir/default
      '')
      lm_sensors
      dune3d
      lsof
      google-chrome
      dbeaver-bin
      timewarrior
      zed-editor
      csview
      wayvnc
      plasticity
      thunderbird
      btop
      libselinux
      ueberzugpp
      barrier
      rtl-sdr
      #"github:mirrexagon/nixpkgs-esp-dev#esp32-id"
    ];
    stateVersion = "23.05";
  };
}

