# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }:
let
  swayConfig = pkgs.writeText "greetd-sway-config" ''
    # `-l` activates layer-shell mode. Notice that `swaymsg exit` will run after gtkgreet.
    exec "${pkgs.greetd.regreet}/bin/regreet ; swaymsg exit"
    exec dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK
    bindsym Mod4+shift+e exec swaynag \
    					-t warning \
    					-m 'What do you want to do?' \
    					-b 'Poweroff' 'systemctl poweroff' \
    					-b 'Reboot' 'systemctl reboot'
    					'';
in
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # <home-manager/nixos>
    ];

  nix = {
    package = pkgs.nixFlakes;
    gc = {
      automatic = true;
      randomizedDelaySec = "14m";
      options = "--delete-older-than 10d";
    };

    extraOptions = ''
      		  experimental-features = nix-command flakes
      		  '';
  };
  # programs.home-manager.enable = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    stdenv.cc.cc
    openssl
    libgcc.lib
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "python3.10-requests-2.28.2"
    "python3.10-cryptography-40.0.1"
  ];
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.sway}/bin/sway --config ${swayConfig}";
      };
    };
  };
  # services.desktopManager.cosmic.enable = true;
  # services.displayManager.cosmic-greeter.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.flatpak.enable = true;
  services = {
    syncthing = {
      enable = true;
      user = "walke";
      dataDir = "/home/walke/Documents"; # Default folder for new synced folders
      configDir = "/home/walke/.config/syncthing"; # Folder for Syncthing's settings and keys
    };
  };

  virtualisation.docker.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    # plugins = [
    # 	pkgs.vimPlugins.nvim-treesitter
    # 	pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    # ];
    #configure = {
    #customRC = (lib.fileContents ../.dotfiles/nvim/init.lua);
    #packages.myVimPackage = with pkgs.vimPlugins; {
    #start = [ nvim-treesitter.withAllGrammars ];
    #opt = [ ];
    #};
    #};
  };
  programs.sway.enable = true;
  nix.optimise.automatic = true;

  programs.fish.enable = true;
  programs.dconf.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # services.xserver.enable = true;
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  networking.hostName = "odin"; # Define your hostname.
  networking.openconnect.package = pkgs.unstable.openconnect;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
  hardware.graphics.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  # services.greetd = {
  #   enable = true;
  #   vt = 6;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet --user-menu -r --time --cmd Hyprland";
  #       user = "greeter";
  #     };
  #     # initial_session = default_session;
  #   };
  # };


  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.walke = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "Adam Walker";
    extraGroups = [ "networkmanager" "wheel" "docker" "storage" ];
    packages = with pkgs; [
      home-manager
    ];
  };

  # programs.home-manager.enable = true;
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [ "walke" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    })
    )
    lf
    libgcc
    eza
    zellij
    rofi-wayland
    fish
    lazygit
    libnotify
    swaynotificationcenter
    alacritty
    rustup
    gimp
    git
    qemu
    wget
    zoxide
    nodejs_18
    typescript
    wl-clipboard
    bat
    du-dust
    bottom
    htop
    fzf
    swww
    webkitgtk
    vpnc-scripts
    libnma
    wireplumber
    playerctl
    wlogout
    killall
    zig
    ripgrep
    polkit_gnome
    gnome-keyring
    adwaita-icon-theme
    docker
    theme-obsidian2
    juno-theme
    papirus-icon-theme
    oranchelo-icon-theme
    numix-icon-theme
    numix-cursor-theme
    catppuccin-cursors
    rose-pine-gtk-theme
    pop-gtk-theme
    pop-gtk-theme
    omni-gtk-theme
    fluent-gtk-theme
    colloid-gtk-theme
    glib
    nwg-look
    gamescope
    zip
    unzip
    go_1_22
    openconnect
    libnma-gtk4
    gnome.networkmanager-openconnect
    gtklock
    # localsend
  ];

  fonts.packages = with pkgs; [
    nerdfonts #.override { fonts = [ "DroidSansMono" ]; })
    dejavu_fonts # mind the underscore! most of the packages are named with a hypen, not this one however
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];

  programs.steam = {
    enable = true;
  };

  home-manager.backupFileExtension = "backups";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  # services.xserver.enable = true;
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # services.xrdp.enable = true;
  # services.xrdp.defaultWindowManager = "Hyprland";
  # services.xrdp.openFirewall = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = [ "walke" ];
      UseDns = false;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password";
    };
    extraConfig = "\nAcceptEnv NIX_L*\n";
  };
  # programs.ssh.enable = true;
  programs.ssh.startAgent = true;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services.gtklock = { };
  system.autoUpgrade.enable = true;


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [22];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = true;
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

