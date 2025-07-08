# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs-stable, pkgs-unstable, systemSettings, userSettings, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./system/app/flatpak.nix
      ./system/app/virt.nix
      ./system/hardware/bluetooth.nix
      # ./system/hardware/gpu.nix
      ./system/hardware/kernel.nix
      ./system/hardware/systemd.nix
      ./system/hardware/time.nix
      ./system/security/automount.nix
      ./system/security/firewall.nix
      ./system/security/gpg.nix
      ./system/security/sshd.nix
    ];

  # SPICE SETUP
  services.spice-vdagentd.enable = true;
  services.udev.packages = with pkgs-stable; [spice-vdagent];
  services.dbus.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

   # Disable legacy BIOS grub install
  boot.loader.grub.enable = false;

#  boot.initrd.luks.devices."luks-bd5ad866-7f14-464b-acf9-b319bd2c7cd6".device = "/dev/disk/by-uuid/bd5ad866-7f14-464b-acf9-b319bd2c7cd6";
  # Setup keyfile
#  boot.initrd.secrets = {
#    "/boot/crypto_keyfile.bin" = null;
 # };

#  boot.loader.grub.enableCryptodisk = true;

#  boot.initrd.luks.devices."luks-b023ebc7-e9c5-48d6-b8cb-9d4a992342bc".keyFile = "/boot/crypto_keyfile.bin";
#  boot.initrd.luks.devices."luks-bd5ad866-7f14-464b-acf9-b319bd2c7cd6".keyFile = "/boot/crypto_keyfile.bin";
  networking.hostName = systemSettings.hostname; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

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

  programs.hyprland.enable = userSettings.wm == "hyprland";
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
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = "alin";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs-stable.zsh;
  };

  programs.zsh.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs-stable; [
   wget
   git
   xclip
   waybar
   spice-vdagent
   tree
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  nix.settings.experimental-features = ["nix-command" "flakes"];
}
