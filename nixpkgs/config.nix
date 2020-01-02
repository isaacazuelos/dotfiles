{
  allowUnfree = true;
  packageOverrides = pkgs: with pkgs; rec {
    polybar-i3 = pkgs.polybar.override {
      i3Support = true;
    };

    david = pkgs.buildEnv {
      name = "david";
      paths = [
        # Command Line Tools
        any-nix-shell
        bat
        cava
        cmatrix
        exa
        gotop
        htop
        ledger
        neofetch
        ripgrep
        starship
        tmux
        tree
        killall

        # Deskotp Apps
        alacritty
        firefox
        polybar-i3
        vscode
        feh
      ];
      extraOutputsToInstall = [ "man" "info" ];
    };
  };
}
