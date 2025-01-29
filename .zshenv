## .zshenv

# Define user direcotires
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export EDITOR=vim
export VISUAL="$EDITOR "
export SYSTEMD_EDITOR=$EDITOR
export PAGER='less'
export BROWSER=/usr/bin/xdg-open

export NALI_HOME="$XDG_CONFIG_HOME"/nali

# ignore duplicated path
typeset -U path

# (N-/): do not register if the directory is not exists
#  N: NULL_GLOB option (ignore path if the path does not match the glob)
#  -: follow the symbol links
#  /: ignore files
path=(
    $XDG_CONFIG_HOME/zsh.d/functions(N-/)
    $HOME/.pyenv/shims(N-/)                         # pyenv
    $HOME/.local/bin(N-/)
    /usr/local/opt/coreutils/libexec/gnubin(N-/)    # macos
    /usr/local/bin(N-/)
    /usr/bin(N-/)
    /bin(N-/)
    /usr/local/sbin(N-/)
    /usr/sbin(N-/)
    /sbin(N-/)
    $path
)

typeset -U fpath
fpath=(
    $XDG_CONFIG_HOME/zsh.d/completions(N-/)
    $XDG_CONFIG_HOME/zsh.d/functions(N-/)
    /usr{/local,}/share/zsh/{site-functions,vendor-completions}(-/N)
    $fpath
)

typeset -U manpath
manpath=(
    $HOME/.local/share/man(N-/)
    $manpath
    /usr/{local,}/share/man(N-/)
)
# vim: ft=zsh sw=4 ts=8 sts=4 et
