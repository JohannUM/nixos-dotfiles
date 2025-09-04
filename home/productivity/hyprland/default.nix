{
  config,
  lib,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    ./binds.nix
    ./hyprland.nix
    ./waybar
    ./hyprpaper.nix
  ];
}