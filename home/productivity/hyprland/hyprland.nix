{
  config,
  lib,
  ...
}: {
  wayland.windowManager.hyprland = {

    enable = true;
    package = null;
    portalPackage = null;

    settings = {

      xwayland = {
        force_zero_scaling = true;
      };

      env = [
        "NIXOS_OZONE_WL,1"
        "GDK_SCALE,1.6"
      ];

      input = {
        kb_layout = "de";
        touchpad.natural_scroll = true;
      };
      
      monitor = [
        ",preferred,auto,auto"
        "eDP-1,preferred,auto,1.6"
      ];
      
      exec-once = [
        "waybar"
        "hyprpaper"
        "hypridle"
      ];
    };
  };
}