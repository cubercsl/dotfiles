## .zprofile

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

fpath=(
    $XDG_CONFIG_HOME/zsh.d/completions(N-/)
    /usr/local/share/zsh-completions    # macos
    $fpath
)

typeset -U manpath
manpath=(
    $HOME/.local/share/man(N-/)
    $XDG_DATA_HOME/man(N-/)
    /usr/local/share/man(N-/)
    /usr/share/man(N-/)
    $manpath
)

# vim: ft=zsh sw=4 ts=8 sts=4 et: