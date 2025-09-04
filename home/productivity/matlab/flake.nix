{
  description = "My Matlab flake";

  inputs = {

  };

  outputs = { self, nixpkgs }: 
  let 
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    targetPkgs = import ./dependencies.nix;
    runScriptPrefix = { errorOut ? true }:
      ''
        # Needed for simulink even on wayland systems
        export QT_QPA_PLATFORM=xcb
        # Search for an imperative declaration of the installation directory of matlab
        if [[ -f ~/.config/matlab/nix.sh ]]; then
          source ~/.config/matlab/nix.sh
      '' + pkgs.lib.optionalString errorOut ''else
          echo "nix-matlab-error: Did not find ~/.config/matlab/nix.sh" >&2
          exit 1
        fi
        if [[ ! -d "$INSTALL_DIR" ]]; then
          echo "nix-matlab-error: INSTALL_DIR $INSTALL_DIR isn't a directory" >&2
          exit 2
      '' + ''
        fi
      '';

      desktopItem = pkgs.makeDesktopItem {
        desktopName = "Matlab";
        name = "matlab";
        # We use substituteInPlace after we run `install`
        # -desktop is needed, see:
        # https://www.mathworks.com/matlabcentral/answers/20-how-do-i-make-a-desktop-launcher-for-matlab-in-linux#answer_25
        exec = "@out@/bin/matlab -desktop %F";

        icon = "matlab";
        # Most of the following are copied from octave's desktop launcher
        categories = [
          "Utility"
          "TextEditor"
          "Development"
          "IDE"
        ];
        mimeTypes = [
          "text/x-octave"
          "text/x-matlab"
        ];
        keywords = [
          "science"
          "math"
          "matrix"
          "numerical computation"
          "plotting"
        ];
      };

      shellHooksCommon = (runScriptPrefix {}) + ''
        export C_INCLUDE_PATH=$INSTALL_DIR/extern/include:$C_INCLUDE_PATH
        export CPLUS_INCLUDE_PATH=$INSTALL_DIR/extern/include:$CPLUS_INCLUDE_PATH
        # Rename the variable for others to extend it in their shellHook
        export MATLAB_INSTALL_DIR="$INSTALL_DIR"
        unset INSTALL_DIR
      '';

      metaCommon = with pkgs.lib; {
        homepage = "https://www.mathworks.com/";
        # This license is not of matlab itself, but for this repository
        license = licenses.mit;
        # Probably best to install this completely imperatively on a system other
        # then NixOS.
        platforms = platforms.linux;
      };
  in {
    packages.x86_64-linux.matlab = pkgs.buildFHSEnv {
      name = "matlab";
      inherit targetPkgs;

      extraInstallCommands = ''
        install -Dm644 ${desktopItem}/share/applications/matlab.desktop $out/share/applications/matlab.desktop
        substituteInPlace $out/share/applications/matlab.desktop \
          --replace "@out@" ${placeholder "out"}
        install -Dm644 ${./icons/hicolor/256x256/matlab.png} $out/share/icons/hicolor/256x256/apps/matlab.png
        install -Dm644 ${./icons/hicolor/512x512/matlab.png} $out/share/icons/hicolor/512x512/apps/matlab.png
        install -Dm644 ${./icons/hicolor/64x64/matlab.png} $out/share/icons/hicolor/64x64/apps/matlab.png
      '';

      runScript = pkgs.writeScript "matlab-runner" ((runScriptPrefix {}) + ''
        # Needed in order to run and load NixOS' executables and shared objects
        # installed to the FHS environment. Forces matlab to not use their
        # potentially outdated and incompatible libstdc++.
        exec env \
          LD_PRELOAD=/lib/libstdc++.so \
          LD_LIBRARY_PATH=/usr/lib/xorg/modules/dri/ \
          $INSTALL_DIR/bin/matlab "$@"
      '');
      meta = metaCommon // {
        description = "Matlab itself - the GUI launcher";
      };
    };

    packages.x86_64-linux.matlab-shell = pkgs.buildFHSEnv {
      name = "matlab-shell";
      inherit targetPkgs;
      runScript = pkgs.writeScript "matlab-shell-runner" ((runScriptPrefix { errorOut = false; }) + ''
        cat <<EOF
        ============================
        welcome to nix-matlab shell!

        To install matlab:
        4. Finish the installation, and exit the shell (with \`exit\`).
        5. Follow the rest of the instructions in the README to make matlab
           executable available anywhere on your system.
        ============================
        EOF
        exec bash
      '');
      meta = metaCommon // {
        description = "A bash shell from which you can install matlab or launch matlab from CLI";
      };
    };
    overlay = final: prev: {
      inherit (self.packages.x86_64-linux)
        matlab
        matlab-shell
      ;
    };
    inherit shellHooksCommon;
    inherit targetPkgs;
    devShell.x86_64-linux = pkgs.mkShell {
      buildInputs = [
        self.packages.x86_64-linux.matlab-shell
      ];
      # From some reason using the attribute matlab-shell directly as the
      # devShell doesn't make it run like that by default.
      shellHook = ''
        exec matlab-shell
      '';
    };

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.matlab;
  };
}