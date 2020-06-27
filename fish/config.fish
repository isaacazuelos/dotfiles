set -x EDITOR emacs
set -x fish_greeting

# I know these are bad from on nix, sue me.
set -x fish_user_paths $HOME/.cargo/bin $HOME/.local/bin

any-nix-shell fish --info-right | source
starship init fish | source

alias ls=exa
alias e="emacs -nw"

abbr -g bank ledger -f ~/Documents/banking/current.ledger
