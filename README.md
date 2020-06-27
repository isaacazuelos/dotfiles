# Dotfiles

My configuration files.

Most of these are pretty straight-forward, where the files just need
to be symlinked into position.

Things are a bit more complicated for nixos, and the solution isn't
very elegant at the moment. For now I just clone the repo and copy the
files in place to install, and then clone as the user and symlink
after.

Once the system is installed and everything is linked into place, I
can install the packages defined in nixpkgs per machine with
`nix-env`.

# Machines

- David-8 is the name of my desktop.
- Very is a VPS.
