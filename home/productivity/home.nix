{ config, pkgs, ... }:

{
  imports = [
    ./hyprland
    ./terminal
    ../common
  ];
  
  home.username = "johann";
  home.homeDirectory = "/home/johann";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    vscode
    wofi
    firefox
    kitty
    hypridle
    hyprpaper
    waybar
    cowsay
    networkmanagerapplet
    _1password-gui
    zoom-us
    thunderbird
    rmapi
    obsidian
    teams-for-linux
    bluez
    blueman
  ];

  programs.firefox = {
    enable = true;
  };

  programs.ssh = {
    enable = true;
  };

  services.ssh-agent.enable = true;

  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;

      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      music = "${config.home.homeDirectory}/Media/Music";
      videos = "${config.home.homeDirectory}/Media/Videos";
      pictures = "${config.home.homeDirectory}/Media/Pictures";
      templates = "${config.home.homeDirectory}/Templates";
      desktop = null;
      publicShare = null;
      extraConfig = {
        XDG_DOTFILES_DIR = "${config.home.homeDirectory}/.dotfiles";
        XDG_PROGRAMS_DIR = "${config.home.homeDirectory}/Programs";
      };
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/johann/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";            
    MOZ_ENABLE_WAYLAND = "1";         # Firefox, if applicable
    QT_QPA_PLATFORM = "wayland";
    XDG_SESSION_TYPE = "wayland";
    GRB_LICENSE_FILE = "/home/johann/Documents/Licenses/gurobi.lic";
    GUROBI_HOME = "/home/johann/Programs/gurobi1202/linux64";
    GUROBI_PATH = "/home/johann/Programs/gurobi1202/linux64";
    LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ "/home/johann/Programs/gurobi1202/linux64" ]}:$LD_LIBRARY_PATH";
  };

  home.sessionPath = [
    "/home/johann/Programs/gurobi1202/linux64/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
