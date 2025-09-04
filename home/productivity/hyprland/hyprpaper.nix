{
  config,
  lib,
  outputs,
  pkgs,
  ...
}: {
  services.hyprpaper = {
    enable = true;

    settings = {
      preload = ["~/Downloads/wallpaper.webp"];
      wallpaper = [", ~/Downloads/wallpaper.webp"];
    };
  };
}