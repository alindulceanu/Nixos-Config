{ config, lib, pkgs-stable,... }:
{
  options = {
    virt.enable = lib.mkEnableOption "enables virtualisation";
  };

  config = lib.mkIf config.virt.enable {
    environment.systemPackages = with pkgs-stable; [ podman virt-manager distrobox ];
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs-stable.qemu_kvm;
          runAsRoot = false;
          swtpm.enable = true;
          ovmf = {
            enable = true;
            packages = [ pkgs-stable.OVMFFull.fd ];
          };
        };
      };
    };
    virtualisation.podman.enable = true;
  };
}
