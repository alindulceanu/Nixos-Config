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
    username = "aln";
    hostname = "laptop";
  };
in
{
  imports =
    [ # Include the results of the hardware scan
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
    bat.enable = true;
    bootScreen.theme = "cubes";
#    audio = {
#      enable = true;
#      backend = "pulseaudio";
#    };

    hibernate = {
      enable = true;
      swapOffset = "10467328";
      rootPath = config.fileSystems."/".device; 
    };

    settings = {
      timezone = "Europe/Bucharest";
      locale = "en_US.UTF-8";
    };
    
    networking = {
      enable = true;
      proxyUrl = null;
      bridge = {
        enable = false;
        target = "wlp2s0";
      };
    };

    services.dbus.enable = true;

    # Enable CUPS to print documents.
    services.printing.enable = true;

    programs.hyprland.enable = true;

    # Enable the X11 windowing system.
    # You can disable this if you're only using the Wayland session.
    services.xserver = {
      enable = true;
    };
    services = {
      libinput = {
        enable = true;
        touchpad.naturalScrolling = true;
      };
    };

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

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${systemSettings.username} = {
      isNormalUser = true;
      description = "${systemSettings.username}";
      extraGroups = [ "libvirtd" "kvm" "wheel" "audio" "video" ];
      shell = pkgs-stable.zsh;
    };

    programs.zsh.enable = true;

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
      default = "laptop";
      description = "Sets the machine's Host Name";
    };
  };
}
