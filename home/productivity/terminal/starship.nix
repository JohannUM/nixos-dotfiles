{
  config,
  lib,
  outputs,
  pkgs,
  ...
}: 
  let
    promptOrder = [
      "{custom.prefix}"
      "{custom.prefix_operating}"
      "{custom.prefix_close}"
      "directory"
      "{custom.directory_close}"
      "git_branch"
      "git_status"
      "{custom.git_close}"
      "line_break"
      "character"
    ];
    promptFormat = lib.concatStrings (map (s: "\$${s}") promptOrder);
  in {
    programs.starship = {
    enable = true;
    settings = {
      format = promptFormat;

      directory = {
        style = "fg:#e3e5e5 bg:#769ff0";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };

      custom = {
        prefix = {
          symbol = "░▒▓";
          format = "[$symbol]($style)";
          style = "#a3aed2";
          when = true;
        };

        prefix_operating = {
          symbol = "  ";
          format = "[$symbol]($style)";
          style = "bg:#a3aed2 fg:#090c0c";
          when = true;
        };

        prefix_close = {
          symbol = " ";
          format = "[$symbol]($style)";
          style = "bg:#769ff0 fg:#a3aed2";
          when = true;
        };

        directory_close = {
          symbol = " ";
          format = "[$symbol]($style)";
          style = "fg:#769ff0 bg:#394260";
          when = true;
        };

        git_close = {
          symbol = " ";
          format = "[$symbol]($style)";
          style = "fg:#394260 bg:#212736";
          when = true;
        };
      };

      git_branch = {
        symbol = "";
        style = "bg:#394260";
        format = "[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
      };

      character = {
        success_symbol = "[›](bold green)";
        error_symbol = "[›](bold red)";
      };

      git_status = {
        style = "bg:#394260";
        format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
        deleted = "✗";
        modified = "✶";
        staged = "✓";
        stashed = "≡";
      };

      nix_shell = {
        symbol = " ";
        heuristic = true;
      };
    };
  };
}