{
  allowUnfree = true;
  packageOverrides = pkgs: with pkgs; rec {
    
    common-tools = pkgs.buildEnv {
      name = "common-tools";
      paths = [
        any-nix-shell
        bat
        cava
        cmatrix
        exa
        fzf
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
	emacs
	riot-desktop
        alacritty
        discord
        firefox
	kdeApplications.spectacle
	vscode
      ];
      extraOutputsToInstall = [ "man" "info" ];
    };
  };
}
