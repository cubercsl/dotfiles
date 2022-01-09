## .zshrc

OS=${$(uname)%_*}
if [[ $OS == "CYGWIN" || $OS == "MSYS" ]]; then
    OS=Linux
elif [[ $OS == "Darwin" ]]; then
    OS=FreeBSD
fi

_zhist=$XDG_CONFIG_HOME/zsh.d/zhistory

export HISTFILE=${_zhist}/zsh_history
export _ZL_DATA=${_zhist}/zlua

HISTSIZE=100000
SAVEHIST=100000

ZDOTDIR=$XDG_CONFIG_HOME/zsh.d
ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump"

_load_profiles=(
    check
    config
    plugin
    alias
    completion
)

for file in ${_load_profiles[@]}; do
    [[ ! -r "$ZDOTDIR/$file.zsh" ]] || source "$ZDOTDIR/$file.zsh"
done
unset file

if command -v starship 2>&1 >/dev/null; then
    eval "$(starship init zsh)"
fi

# Load user config.
if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

unset OS

# vim: ft=zsh sw=4 ts=8 sts=4 et:
