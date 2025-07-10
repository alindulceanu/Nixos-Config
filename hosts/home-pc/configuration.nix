# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs-stable, pkgs-unstable, ... }:
let
  systemSettings = {
    timezone = "Europe/Bucharest";
    profile = "personal"; # todo
    locale = "en_US.UTF-8";
    bootMode = "uefi"; # todo
    gpuType = "intel"; # todo
    wm = "cosmic";
    dm = "sddm"; # todo
    displayServer = "wayland";
    username = "alin";
  };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../../system
    ];

  # System software settings
  flatpak.enable = false;
  virt.enable = true;
  bluetooth.enable = true;
  gpu.enable = false; # todo
  automount.enable = true;
  firewall.enable = true;
  ssh.enable = true;


  # SPICE SETUP
  services.spice-vdagentd.enable = true;
  services.udev.packages = with pkgs-stable; [spice-vdagent];
  services.dbus.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;

 
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = true;
  };

  networking.hostName = "home-pc"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = systemSettings.timezone;

  # Select internationalisation properties.
  i18n.defaultLocale = systemSettings.locale;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ro_RO.UTF-8";
    LC_IDENTIFICATION = "ro_RO.UTF-8";
    LC_MEASUREMENT = "ro_RO.UTF-8";
    LC_MONETARY = "ro_RO.UTF-8";
    LC_NAME = "ro_RO.UTF-8";
    LC_NUMERIC = "ro_RO.UTF-8";
    LC_PAPER = "ro_RO.UTF-8";
    LC_TELEPHONE = "ro_RO.UTF-8";
    LC_TIME = "ro_RO.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;

  programs.hyprland.enable = systemSettings.wm == "hyprland";
  services.desktopManager.cosmic.enable = systemSettings.wm == "cosmic";
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "ro";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${systemSettings.username} = {
    isNormalUser = true;
    description = "${systemSettings.username}";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
    shell = pkgs-stable.zsh;
  };

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs-stable; [
    wget
    git
    tree
    pwvucontrol
  ] ++ ( with pkgs-unstable; [

    ]
  );

  system.stateVersion = "25.05";

  nix.settings.experimental-features = ["nix-command" "flakes"];
}
