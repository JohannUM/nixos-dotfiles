{
  config,
  lib,
  outputs,
  pkgs,
  ...
}: {
  programs.kitty = {
    enable = true;
    font = {
      size = 12;
      name = "JetBrains Mono";
    };
    settings = {
      confirm_os_window_close = 0;
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      mouse_hide_wait = "-1.0";
      background_opacity = "0.5";
      window_padding_width = "15";
    };
  };
}
