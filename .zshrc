## .zshrc

_cfg_info() {
    print -P "%F{green}[INFO]%f $1"
}

_cfg_warning() {
    print -P "%F{yellow}[WARN]%f $1"
}

_cfg_error() {
    print -P "%F{red}[ERROR]%f $1"
}

_zhist=$XDG_CONFIG_HOME/zsh.d/zhistory

export HISTFILE=${_zhist}/zsh_history
export _ZL_DATA=${_zhist}/zlua

HISTSIZE=100000
SAVEHIST=100000
ZDOTDIR="$XDG_CONFIG_HOME/zsh.d"
ZSH_CACHE_HOME="$XDG_CACHE_HOME/zsh"
ZSH_COMPDUMP="$ZSH_CACHE_HOME/zcompdump"

_profiles=(
    check
    config
    alias
    completion
    keybind
    plugin
)

for _profile in ${_profiles[@]}; do
    [[ -r "$ZDOTDIR/$_profile.zsh" ]] && source "$ZDOTDIR/$_profile.zsh" ||\
        _cfg_warning "Can not found $_profile.zsh." 
done
unset _profile

if command -v starship 2>&1 >/dev/null; then
    eval "$(starship init zsh)"
fi

# Load user config.
if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

unset OS

# vim: ft=zsh sw=4 ts=8 sts=4 et:
