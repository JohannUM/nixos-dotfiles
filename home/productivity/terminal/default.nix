{
  config,
  lib,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    ./kitty.nix
    ./zsh.nix
    ./starship.nix
  ];
}