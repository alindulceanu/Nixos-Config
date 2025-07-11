{ ... }:
{
  imports = [
    ./gpu.nix
    ./time.nix
    ./kernel.nix
    ./systemd.nix
    ./bluetooth.nix
    ./spice.nix
    ./bootloader.nix
    ./networking.nix
    ./pipewire.nix
    ./pulseaudio.nix
  ];
}
