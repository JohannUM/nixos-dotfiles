flake-overlays:

{ config, pkgs, ... }:

let 
  systemConfig = {
    hostName = "framework";
    timeZone = "Europe/Berlin";
  };
  
  RWithPackages = with pkgs; rWrapper.override{ packages = with rPackages; [ languageserver ggplot2 igraph RCy3 neo4r dplyr purrr ]; };
in {
  imports =
    [ 
      ./hardware-configuration.nix
      ./hyprland.nix
      ../common
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;  

  networking.hostName = systemConfig.hostName; 

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = systemConfig.timeZone;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  services.fwupd.enable = true;

  # Configure console keymap
  console.keyMap = "de";

  nixpkgs.overlays = [
    (
      final: prev: {

      }
    )
  ] ++ flake-overlays;

  environment.systemPackages = with pkgs; [
    vim 
    wget
    git
    brightnessctl
    playerctl
    htop
    unzip
    matlab
    RWithPackages
    cytoscape
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  programs.zsh.enable = true;

  # hardware.pulseaudio.enable = true;
  # services.pulseaudio = {
  #   enable = true;
  #   package = pkgs.pulseaudioFull;
  # };

  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment? 
}
