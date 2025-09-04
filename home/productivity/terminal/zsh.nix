{
  config,
  lib,
  outputs,
  pkgs,
  ...
}: {
    programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
  };
}