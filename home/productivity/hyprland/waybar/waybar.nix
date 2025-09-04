{
  config,
  lib,
  ...
}: let 
  theme = import ../../themes/base.nix;
in {
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        margin-top = 10;
        margin-bottom = 0;
        margin-left = 14;
        margin-right = 14;
        spacing = 0;

        modules-left = [
          "network"
          "cpu"
          "temperature"
        ];

        modules-center = [
          "hyprland/workspaces"
        ];

        modules-right = [
          "battery"
          "tray"
          "clock"
        ];

        "hyprland/window" = {
          "max-length" = 40;
          "seperate-outputs" = true;
        };

        "hyprland/workspaces" = {
          "on-click" = "activate";
          "active-only" = false;
          "all-outputs" = true;
          "format" = "{}";
          "format-icons" = {
            "urgent" = "";
            "active" = "";
            "default" = "";
          };
          "persistent-workspaces" = {
            "*" = 5;
          };
        };

        "cpu" = {
          "format" = " {usage}%";
        };

        "battery" = {
          "states" = {
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{icon} {capacity}%";
          "format-charging" = "󰂄 {capacity}%";
          "format-plugged" = " {capacity}%";
          "format-alt" = "{icon}  {time}";
          "format-icons" = [" " " " " " " " " "];
        };

        "clock" = {
          "format" = "{:%H:%M %a}";
          "tooltip" =  false;
        };

        "network" = {
          "format" = "{ifname}";
          "format-wifi" = " ";
          "format-ethernet" = "󰌗 ";
          "format-disconnected" = "⚠";
          "tooltip-format" = "{ifname} via {gwaddri}";
          "tooltip-format-wifi" = "  {ifname} @ {essid}\nIP: {ipaddr}\nStrength: {signalStrength}%\nFreq: {frequency}MHz\nUp: {bandwidthUpBits} Down: {bandwidthDownBits}";
          "tooltip-format-ethernet" = "󰌗 {ifname}\nIP: {ipaddr}\n up: {bandwidthUpBits} down: {bandwidthDownBits}";
          "tooltip-format-disconnected" = "Disconnected";
          "max-length" = 50;
          "on-click" = "nm-connection-editor";
        };
      };
    };

    style = ''
      @define-color backgroundLight ${theme.background_light};
      @define-color backgroundDark ${theme.background_dark};
      @define-color backgroundRight ${theme.waybar.background_right};
      @define-color borderRight ${theme.waybar.border_right};
      @define-color textRight ${theme.waybar.text_right};
      @define-color iconColor ${theme.waybar.icons};
      @define-color backgroundAlert ${theme.waybar.background_alert};
      @define-color textAlert ${theme.waybar.text_alert};
      @define-color clockText ${theme.waybar.clock_text};
      @define-color clockBackground ${theme.waybar.clock_background};
      @define-color clockBorder ${theme.waybar.clock_border};
      @define-color workspaceBackground ${theme.waybar.workspace_background};
      @define-color workspaceBorder ${theme.waybar.workspace_border};
      @define-color workspaceActiveBackground ${theme.waybar.workspace_active_background};
      @define-color workspaceActiveText ${theme.waybar.workspace_active_text};
      @define-color workspaceInactiveBackground ${theme.waybar.workspace_inactive_background};
      @define-color workspaceInactiveText ${theme.waybar.workspace_inactive_text}; 

      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono NF";
        font-size: 18px;
        min-height: 0;
      }

      window#waybar {
        background-color: rgba(0,0,0,0.8);
        border-bottom: 0px solid #ffffff;
        background: transparent;
        transition-property: background-color;
        transition-duration: .5s;
      }

      #clock {
        background-color: @clockBackground;
        color: @clockText;
        border-radius: 15px;
        padding: 3px 10px 3px 10px;
        margin: 0px 0px 0px 10px;
        border:3px solid @clockBorder;
        font-weight: bold;
      }

      #workspaces {
        background: @workspaceBackground;
        border-radius: 15px;
        border: 2px solid @workspaceBorder;
        font-weight: bold;
        color: @workspaceBackground;
      }

      #workspaces button {
        padding: 0px 10px 0px 10px;
        margin: 4px 4px 4px 4px;
        border-radius: 15px;
        border: 0px;
        color: @workspaceInactiveText;
        background: @workspaceInactiveBackground;
        transition: all 0.3s ease-in-out;
        opacity: 0.9;
      }

      #workspaces button.active {
        color: @workspaceActiveText;
        background: @workspaceActiveBackground;
        border-radius: 15px;
        min-width: 35px;
        transition: all 0.3s ease-in-out;
        opacity: 1.0;
      }

      #workspaces button:hover {
        color: @workspaceInactiveText;
        background: @workspaceInactiveBackground;
        border-radius: 15px;
        opacity: 1.0;
      }

      #cpu {
        background-color: @backgroundRight;
        color: @textRight;
        border-radius: 15px;
        padding: 3px 13px 3px 13px;
        margin: 0px 5px 0px 0px;
        border:2px solid @borderRight;
      }

      #network {
        background-color: @backgroundRight;
        color: @textRight;
        border-radius: 15px;
        padding: 3px 13px 3px 13px;
        margin: 0px 5px 0px 0px;
        border:2px solid @borderRight;
      }

      #temperature {
        background-color: @backgroundRight;
        color: @textRight;
        border-radius: 15px;
        padding: 3px 13px 3px 13px;
        margin: 0px 5px 0px 0px;
        border:2px solid @borderRight;
      }

      #battery {
        background-color: @backgroundRight;
        color: @textRight;
        border-radius: 15px;
        padding: 3px 13px 3px 13px;
        margin: 0px 5px 0px 0px;
        border:2px solid @borderRight;
      }

      #battery.charging, #battery.plugged {
          color: @textRight;
          background-color: @backgroundRight;
      }

      #battery.critical:not(.charging) {
          background-color: @backgroundAlert;
          color: @textAlert;
          animation-name: blink;
          animation-duration: 1s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      tooltip {
        border-radius: 16px;
        background-color: @backgroundRight;
        opacity:0.9;
        padding:15px;
        margin:0px;
      }

      tooltip label {
        color: @textRight;
        font-size: 15px;
      }
    '';
  };
}