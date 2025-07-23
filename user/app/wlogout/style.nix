{ config, ... }:
let
  inherit (config.lib.stylix.colors) base00 base01 base02 base03 base04 base05 base06 base07 base08 base09 base0A base0B base0C base0D base0E base0F;

  icon_color = if ( config.stylix.polarity == "dark" ) then "white" else "black";

  fntSize = "15";
  mgn = "10";
  hvr = "5";
  button_rad = "8";
  active_rad = "6";

  iconPath = ./icons;
  lockIcon = "${iconPath}/lock_${icon_color}.png";
  logoutIcon = "${iconPath}/logout_${icon_color}.png";
  hibernateIcon = "${iconPath}/hibernate_${icon_color}.png";
  rebootIcon = "${iconPath}/reboot_${icon_color}.png";
  shutdownIcon = "${iconPath}/shutdown_${icon_color}.png";
  suspendIcon = "${iconPath}/suspend_${icon_color}.png";
in
''
* {
    background-image: none;
    font-size: ${fntSize}px;
}

window {
    background-color: rgba(0, 0, 0, 0.6) ;
}

button {
    color:#${base05} ;
    background-color: #${base00};
    outline-style: none;
    border: none;
    border-width: 0px;
    background-repeat: no-repeat;
    background-position: center;
    background-size: 20%;
    border-radius: 0px;
    box-shadow: none;
    text-shadow: none;
    animation: gradient_f 20s ease-in infinite;
}

button:focus {
    background-color: #${base02};
    background-size: 30%;
}

button:hover {
    background-color: #${base01};
    background-size: 40%;
    border-radius: ${active_rad}px;
    animation: gradient_f 20s ease-in infinite;
    transition: all 0.3s cubic-bezier(.55,0.0,.28,1.682);
}

button:hover#lock {
    border-radius: ${active_rad}px;
    margin : ${hvr}px 0px ${hvr}px ${mgn}px;
}

button:hover#logout {
    border-radius: ${active_rad}px;
    margin : ${hvr}px 0px ${hvr}px 0px;
}

button:hover#suspend {
    border-radius: ${active_rad}px;
    margin : ${hvr}px 0px ${hvr}px 0px;
}

button:hover#shutdown {
    border-radius: ${active_rad}px;
    margin : ${hvr}px 0px ${hvr}px 0px;
}

button:hover#hibernate {
    border-radius: ${active_rad}px;
    margin : ${hvr}px 0px ${hvr}px 0px;
}

button:hover#reboot {
    border-radius: ${active_rad}px;
    margin : ${hvr}px ${mgn}px ${hvr}px 0px;
}

#lock {
    background-image: image(url("${lockIcon}"));
    border-radius: ${button_rad}px 0px 0px ${button_rad}px;
    margin : ${mgn}px 0px ${mgn}px ${mgn}px;
}

#logout {
    background-image: image(url("${logoutIcon}"));
    border-radius: 0px 0px 0px 0px;
    margin : ${mgn}px 0px ${mgn}px 0px;
}

#suspend {
    background-image: image(url("${suspendIcon}"));
    border-radius: 0px 0px 0px 0px;
    margin : ${mgn}px 0px ${mgn}px 0px;
}

#shutdown {
    background-image: image(url("${shutdownIcon}"));
    border-radius: 0px 0px 0px 0px;
    margin : ${mgn}px 0px ${mgn}px 0px;
}

#hibernate {
    background-image: image(url("${hibernateIcon}"));
    border-radius: 0px 0px 0px 0px;
    margin : ${mgn}px 0px ${mgn}px 0px;
}

#reboot {
    background-image: image(url("${rebootIcon}"));
    border-radius: 0px ${button_rad}px ${button_rad}px 0px;
    margin : ${mgn}px ${mgn}px ${mgn}px 0px;
}
''
