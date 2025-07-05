{ config, pkgs, ... }:
let
	leftwmThemes = pkgs.fetchFromGitHub {
		owner = "leftwm";
		repo = "leftwm";
		rev = "38c2b08";
		sha256 = "sha256-k72Lr/XEUjc92LtBhmCO7nV4pJV0zC5ffkcN53kCT9Y=";
	};
in
{
	system.activationScripts.leftwmTheme = ''
		mkdir -p /etc/leftwm/themes
		cp -r ${leftwmThemes}/themes/basic_polybar /etc/leftwm/themes
		ln -sf /etc/leftwm/themes/basic_polybar /etc/leftwm/current-theme
	'';

	environment.variables.LEFTWM_THEME = "/etc/leftwm/current-theme";
}
