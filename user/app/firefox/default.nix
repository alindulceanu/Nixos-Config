{ inputs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.alin = {
      extensions.packages = with inputs.firefox-extensions.packages."x86_64-linux"; [
        ublock-origin
      ];
    };
  };
}
