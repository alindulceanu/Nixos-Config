{
  mainBar = {
    "layer"= "top";
    "exclusive" = true;
    "position"= "top";
    "reload_style_on_change"= true;
    "modules-left"= ["custom/notification" "clock" "tray"];
    "modules-center"= ["hyprland/workspaces"];
    "modules-right"= ["group/expand" "bluetooth" "network" "battery" "backlight/slider" "wireplumber"];

    "hyprland/workspaces"= {
        "format"= "{icon}";
        "format-icons"= {
            "active"= "";
            "default"= "";
            "empty"= "";
        };
        "persistent-workspaces"= {
            "*"= [ 1 2 3 4 5 ];
        };
    };
    "clock"= {
        "format"= "{:%H:%M:%S} ";
        "interval"= 1;   
        "tooltip-format"= "<tt>{calendar}</tt>";
        "calendar"= {
            "format"= {
                "today"= "<span color='#fAfBfC'><b>{}</b></span>";
            };
        };
        "actions"= {
            "on-click-right"= "shift_down";
            "on-click"= "shift_up";
        };
    };
    "backlight/slider" = {
        "orientation" = "vertical";
    };
    "wireplumber" = {
        "max-volume" = 150;
        "on-click" = "pwvucontrol";
        "scroll-step" = 1;
        "format" = "{volume}% {icon}";
        "format-icons" = ["" "" ""];
        "format-muted" = "";
    };
    "network"= {
        "format-wifi"= "";
        "format-ethernet"="";
        "format-disconnected"= "";
        "tooltip-format-disconnected"= "Error";
        "tooltip-format-wifi"= "{essid} ({signalStrength}%) ";
        "tooltip-format-ethernet"= "{ifname} 🖧 ";
        "on-click"= "kitty nmtui";
    };
    "bluetooth"= {
        "format-on"= "󰂯";
        "format-off"= "BT-off";
        "format-disabled"= "󰂲";
        "format-connected-battery"= "{device_battery_percentage}% 󰂯";
        "format-alt"= "{device_alias} 󰂯";
        "tooltip-format"= "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
        "tooltip-format-connected"= "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
        "tooltip-format-enumerate-connected"= "{device_alias}\n{device_address}";
        "tooltip-format-enumerate-connected-battery"= "{device_alias}\n{device_address}\n{device_battery_percentage}%";
        "on-click-right"= "blueman-manager";
    }; 
    "battery"= {
        "interval"=30;
        "states"= {
            "good"= 95;
            "warning"= 30;
            "critical"= 20;
        };
        "format"= "{capacity}% {icon}";
        "format-charging"= "{capacity}% 󰂄";
        "format-plugged"= "{capacity}% 󰂄 ";
        "format-alt"= "{time} {icon}";
        "format-icons"= [
            "󰁻"
            "󰁼"
            "󰁾"
            "󰂀"
            "󰂂"
            "󰁹"
        ];
    };
    "custom/expand"= {
        "format"= "";
        "tooltip"= false;
    };
    "custom/endpoint"={
        "format"= "|";
        "tooltip"= false;
    };
    "group/expand"= {
        "orientation"= "horizontal";
        "drawer"= {
            "transition-duration"= 600;
            "transition-to-left"= true;
            "click-to-reveal"= true;
        };
        "modules"= ["custom/expand" "custom/colorpicker" "cpu" "memory" "temperature" "custom/endpoint"];
    };
    "custom/colorpicker"= {
        "format"= "{}";
        "return-type"= "json";
        "interval"= "once";
        "exec"= "~/.config/waybar/scripts/colorpicker.sh -j";
        "on-click"= "~/.config/waybar/scripts/colorpicker.sh";
        "signal"= 1;
    };
    "cpu"= {
        "format"= "󰻠";
        "tooltip"= true;
    };
    "memory"= {
        "format"= "";
    };
    "temperature"= {
        "critical-threshold"= 80;
        "format"= "";
        "thermal-zone" = 4;
    };
    "tray"= {
        "icon-size"= 14;
        "spacing"= 10;
    };
  };
}
