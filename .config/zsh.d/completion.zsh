zmodload zsh/complist

# using hjkl to select completion menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

autoload -Uz compinit
compinit -d "$ZSH_COMPDUMP"

autoload -U +X bashcompinit && bashcompinit

# enable hidden files completion
_comp_options+=(globdots)

# Some functions, like _apt and _dpkg, are very slow. We can use a cache in
# order to speed things up
zstyle ':completion:*' use-cache yes 
_cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcache
zstyle ':completion:*' cache-path $_cache_dir
unset _cache_dir

# ignore duplicate entries
zstyle ':completion:*:history-words'   remove-all-dups yes
zstyle ':completion:*:history-words'   stop yes

# define files to ignore for zcompile
zstyle ':completion:*:*:zcompile:*'    ignored-patterns '(*~|*.zwc)'
zstyle ':completion:correct:'          prompt 'correct to: %e'

# ignore completion functions for commands you don't have:
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'

# correct case
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

zstyle ':completion:*:matches' group yes
zstyle ':completion:*:options' description yes
zstyle ':completion:*:options' auto-description '%d'

###  Color setting
# I use http://jafrog.com/2013/11/23/colors-in-terminal.html to get color code
# colorfull completion list
eval $(dircolors -b)
export ZLSCOLORS="${LS_COLORS}"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
# https://thevaluable.dev/zsh-completion-guide-examples/
# it only supported by gnome-terminal
# https://gist.github.com/inexorabletash/9122583
#zstyle ':completion:*:descriptions' format $'\e[2m -- %d --\e[0m'
zstyle ':completion:*:descriptions' format '%F{blue} -- %d -- %f'
zstyle ':completion:*:messages' format '%F{purple} -- %d -- %f'
zstyle ':completion:*:warnings' format '%F{red}%B -- No Matches Found --%b%f'
zstyle ':completion:*:corrections' format '%F{yellow}%B -- %d (errors: %e) --%b%f'

#错误校正
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
# _extensions 为 *. 补全扩展名
# 在最后尝试使用文件名
zstyle ':completion:*' completer _complete _match _approximate _expand_alias _ignored _files

# allow one error for every three characters typed in approximate completer
zstyle ':completion:*:approximate:'    max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'

zstyle ':completion:*' expand yes 
zstyle ':completion:*' squeeze-shlashes yes
zstyle ':completion::complete:*' '\\'

zstyle ':completion:*' menu select
# 分组显示
zstyle ':completion:*' group-name ''

# 在 alias 之后补全(即把 alias 展开后补全而不是当中单独的命令)
unsetopt complete_aliases

### Autosuggest Setting
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
    OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
    zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
pastefinish() {
    zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
# https://github.com/zsh-users/zsh-autosuggestions/issues/351
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste accept-line)

_ZSH_PLUGINS="/usr/share/zsh/plugins"

_plugins=(
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting
)
for _zsh_plugin in $_plugins[@]; do
    for file (
        $_ZSH_PLUGINS/$_zsh_plugin/$_zsh_plugin.zsh
        /usr/local/share/$_zsh_plugin/$_zsh_plugin.zsh  # macos homebrew
    ); do
        if [[ -r "$file" ]]; then
            source "$file"
            break
        fi
    done
    unset file
done
unset _zsh_plugin

# https://github.com/zsh-users/zsh-history-substring-search#usage
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
#bindkey '^[[A' history-substring-search-up
#bindkey '^[[B' history-substring-search-down
export HISTORY_SUBSTRING_SEARCH_PREFIXED=true

# kill completion
compdef pkill=kill
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -afu$USER'
# Provide more processes in completion of programs like killall:
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'

# ignore-parents after cd ..
zstyle ':completion:*:cd:*' ignore-parents parent pwd

zstyle :compinstall filename "${HOME}/.zshrc"

# By default, the completion doesn't allow option-stacking, meaning if you try to complete docker run -it <TAB> it won't work, because you're stacking the -i and -t options.
zstyle ':completion:*:*:docker:*'   option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# disable fallback to filename completion
zstyle ':completion:*:*:git*:*' use-fallback false

# Ignore pyc files for python
zstyle ':completion:*:*:(python*|pytest):*:*files' ignored-patterns '*.(pyc)(-.)'

# vim: ft=zsh sw=4 ts=8 sts=4 et:
