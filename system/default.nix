{ pkgs-stable, pkgs-unstable, config, lib, ... }:
{
  imports = [
    ./app
    ./hardware
    ./security
  ];
}
