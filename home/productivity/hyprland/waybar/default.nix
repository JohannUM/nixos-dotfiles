{
  config,
  lib,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    ./waybar.nix
  ];
}