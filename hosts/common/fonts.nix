{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      # nerdfonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.departure-mono
    ];

    # causes more issues than it solves
    enableDefaultPackages = false;

    # user defined fonts
    fontconfig.defaultFonts = {
      monospace = ["JetBrains Mono Nerd Font"];
    };
  };
}