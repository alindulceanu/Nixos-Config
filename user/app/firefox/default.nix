{ inputs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.default = {
      extensions = with inputs.firefox-extensions.packages."x86_64-linux"; [
        ublock-origin
      ];
    };
  };
}
