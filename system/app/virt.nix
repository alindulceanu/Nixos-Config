{ config, pkgs-stable, ... }:
{
  environment.systemPackages = with pkgs-stable; [ virt-manager distrobox ];
  virtualisation.libvirtd = {
    allowedBridges = [
      "br0"
      "virbr0"
    ];

    enable = true;
    qemu.runAsRoot = false;
  };
}
