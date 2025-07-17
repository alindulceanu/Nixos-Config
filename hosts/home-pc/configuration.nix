# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, pkgs-stable, pkgs-unstable, config, ... }:
let
  systemSettings = {
    timezone = "Europe/Bucharest";
    profile = "personal"; # todo
    locale = "en_US.UTF-8";
    bootMode = "uefi"; # todo
    gpuType = "intel"; # todo
    dm = "sddm"; # todo
    displayServer = "wayland";
    username = "alin";
    hostname = "home-pc";
  };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../../system
    ];
  config = {
    # System software settings
    flatpak.enable = true;
    virt.enable = true;
    bluetooth.enable = true;
    gpuSoft.enable = true; 
    automount.enable = true;
    firewall.enable = true;
    ssh.enable = false;
    spice.enable = false;
    bootScreen.theme = "cubes";
#    audio = {
#      enable = true;
#      backend = "pulseaudio";
#    };

    settings = {
      timezone = "Europe/Bucharest";
      locale = "en_US.UTF-8";
    };
    
    swapDevices = [{
      device = "/.swapfile";
      size = 8192;
    }];

    networking = {
      enable = true;
      proxyUrl = null;
    };

    services.dbus.enable = true;

    # Enable CUPS to print documents.
    services.printing.enable = true;

    programs.hyprland.enable = true;

    # Enable the X11 windowing system.
    # You can disable this if you're only using the Wayland session.
    services.xserver.enable = true;

    services.displayManager.sddm = {
      enable = true;
      theme = "chili";
      wayland.enable = true;
    };

    systemd.services.display-manager = {
      after = [ "systemd-udev-settle.service" ];
      wants = [ "system-udev-settle.service" ];
    };

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "ro";
      variant = "";
    };
    # Enable touchpad support (enabled default in most desktopManager).
    services.libinput.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${systemSettings.username} = {
      isNormalUser = true;
      description = "${systemSettings.username}";
      extraGroups = [ "libvirtd" "networkmanager" "wheel" "audio" "video" ];
      shell = pkgs-stable.bash;
    };

    security.sudo.enable = true;
    security.sudo.wheelNeedsPassword = true;

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs-stable; [
      wget
      git
      tree
      zsh
      sddm-chili-theme
    ] ++ ( with pkgs-unstable; [

      ]
    );

    system.stateVersion = "25.05";

    nix.settings.experimental-features = ["nix-command" "flakes"];
  };

  options = {
    systemSettings.hostname = lib.mkOption {
      type = lib.types.str;
      default = "home-pc";
      description = "Sets the machine's Host Name";
    };
  };
}
