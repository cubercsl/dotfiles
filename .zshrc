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
ZSH_CACHE_HOME="$XDG_CACHE_HOME/zsh"
ZSH_COMPDUMP="$ZSH_CACHE_HOME/zcompdump"
ZSHCONFIG="$XDG_CONFIG_HOME/zsh.d"

_profiles=(
    check
    prompt
    config
    keybind
    alias
    plugin
    completion
)

for _profile in ${_profiles[@]}; do
    [[ -r "$ZSHCONFIG/$_profile.zsh" ]] && source "$ZSHCONFIG/$_profile.zsh" ||\
        _cfg_warning "Can not load \"$_profile.zsh\"."
done
unset _profile

# Load user config.
if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

unset OS

# vim: ft=zsh sw=4 ts=8 sts=4 et:
