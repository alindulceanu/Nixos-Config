{ lib, config, pkgs-stable, ... }:
{
  options = {
    gpuSoft.enable = lib.mkEnableOption "enables gpu related software";
  };

  config = lib.mkIf config.gpuSoft.enable {
    hardware.graphics.enable = true;

    hardware.graphics.extraPackages = with pkgs-stable; [
      vaapiVdpau
      libvdpau
      mesa
    ];

    hardware.graphics.extraPackages32 = with pkgs-stable; [
      libva
    ];

    # Vulkan drivers
    #hardware.opengl.setLdLibraryPath = true;
    #environment.systemPackages = with pkgs-stable; [
    #  vulkan-tools  # includes vulkaninfo
    #  mesa          # includes both OpenGL and Vulkan drivers for most GPUs
    #];
  };
}

