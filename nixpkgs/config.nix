{
  allowUnfree = true;
  packageOverrides = pkgs: with pkgs; rec {
    polybar-i3 = pkgs.polybar.override {
      i3Support = true;
    };

    common-tools = pkgs.buildEnv {
      name = "common-tools";
      paths = [
        any-nix-shell
        bat
        cava
        cmatrix
        exa
        gotop
        htop
        neofetch
        nixfmt
        ripgrep
        starship
        tmux
        killall
      ];
      extraOutputsToInstall = [ "man" "info" ];
    };

    very = pkgs.buildEnv {
      name = "very";
      paths = [ common-tools ];
      extraOutputsToInstall = [ "man" "info" ];
    };

    david = pkgs.buildEnv {
      name = "david";
      paths = [
        common-tools

        # Deskotp Apps
        alacritty
        emacs
        firefox
        polybar-i3
        vscode
        feh
      ];
      extraOutputsToInstall = [ "man" "info" ];
    };
  };
}
