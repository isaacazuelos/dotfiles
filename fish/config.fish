set -x EDITOR emacs
set -x fish_greeting

any-nix-shell fish --info-right | source
starship init fish | source

alias ls=exa
alias e="emacs -nw"
