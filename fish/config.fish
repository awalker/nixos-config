# ~/.config/fish/config.fish

starship init fish | source
#set -gx GOPATH "$HOME/src/go"
#set -gx GOROOT "$HOME"
set -gx PATH "$HOME/.local/bin" "$HOME/go/bin" $PATH
# set -x GPG_TTY (tty)
set -gx EDITOR hx

# bun
# set --export BUN_INSTALL "$HOME/.bun"
# set --export PATH /home/adam/.local/share/bob/nvim-bin $PATH
# set --export PATH $BUN_INSTALL/bin $PATH
set -gx NIX_LD /run/current-system/sw/share/nix-ld/lib/ld.so
set -gx NIX_LD_LIBRARY_PATH /run/current-system/sw/share/nix-ld/lib

function fish_greeting
    freshfetch
end

zoxide init fish | source
if not pgrep --full ssh-agent | string collect >/dev/null
    eval (ssh-agent -c)
    set -Ux SSH_AGENT_PID $SSH_AGENT_PID
    # set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    set -Ux SSH_AUTH_SOCK $XDG_RUNTIME_DIR/gcr/ssh
end

# set -g PAGER /run/current-system/sw/bin/bat

# opam configuration
#source /home/walke/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
