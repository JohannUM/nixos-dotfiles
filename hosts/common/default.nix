{ config, pkgs, ... }:
{
imports = [
  ./fonts.nix
];

  users.users.johann = {
    isNormalUser = true;
    description = "Johann";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}