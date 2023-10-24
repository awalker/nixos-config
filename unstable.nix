{ config, pkgs, ...}:
let
  baseconfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseconfig; };
in {
  environment.systemPackages = with pkgs; [
    unstable.go_1_21
    unstable.openconnect
    unstable.gnome.networkmanager-openconnect
  ];
}

