{ pkgs-stable, ... }:
{
  boot.kernelPackages = pkgs-stable.linuxPackages_latest;
  boot.consoleLogLevel = 0;
  boot.kernelModules = [ "kvm-intel" ];
}
