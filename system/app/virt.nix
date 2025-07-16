{ config, lib, pkgs-stable,... }:
{
  options = {
    virt.enable = lib.mkEnableOption "enables virtualisation";
  };

  config = lib.mkIf config.virt.enable {
    environment.systemPackages = with pkgs-stable; [ podman virt-manager distrobox qemu_kvm ];
    virtualisation.libvirtd = {
      allowedBridges = [
        "br0"
        "virbr0"
      ];
      

      enable = true;
      qemu.runAsRoot = false;
    };
    virtualisation.podman.enable = true;
  };
}
