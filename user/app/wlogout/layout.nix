[ 
  {
    "label"= "lock";
    "action"= "hyprlock";
    "text"= "Lock";
    "keybind"= "l";
  }
  {
    "label"= "logout";
    "action"= "hyprctl dispatch exit 0";
    "text"= "Logout";
    "keybind"= "e";
  }
  {
    "label"= "suspend";
    "action"= "lockscreen.sh & disown && systemctl suspend";
    "text"= "Suspend";
    "keybind"= "u";
  }
  {
    "label"= "shutdown";
    "action"= "systemctl poweroff";
    "text"= "Shutdown";
    "keybind"= "s";
  }
  {
    "label"= "hibernate";
    "action"= "systemctl hibernate";
    "text"= "Hibernate";
    "keybind"= "h";
  }
  {
    "label"= "reboot";
    "action"= "systemctl reboot";
    "text"= "Reboot";
    "keybind"= "r";
  }
]
