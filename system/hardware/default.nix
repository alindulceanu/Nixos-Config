{ ... }:
{
  imports = [
    ./gpu.nix
    ./time.nix
    ./kernel.nix
    ./systemd.nix
    ./bluetooth.nix
  ];
}
