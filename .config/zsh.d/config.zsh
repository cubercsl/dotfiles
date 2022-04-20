setopt nomatch
zmodload zsh/subreap 2>/dev/null && subreap
autoload -Uz is-at-least
# 自动记住已访问目录栈
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_minus
# 不需要打 cd，直接进入目录
setopt autocd
# 以附加的方式写入历史纪录
setopt append_history
# 不保存重复的历史记录项
setopt hist_save_no_dups
setopt hist_ignore_dups
# 在命令前添加空格，不将此命令添加到记录文件中
setopt hist_ignore_space
#为历史纪录中的命令添加时间戳
setopt extended_history
#允许在交互模式中使用注释  例如：
#cmd #这是注释
setopt interactive_comments
#扩展路径
#/v/c/p/p => /var/cache/pacman/pkg
setopt complete_in_word
# 补全列表不同列可以使用不同的列宽
setopt listpacked
# 补全 identifier=path 形式的参数
setopt magic_equal_subst
# setopt 的输出显示选项的开关状态
setopt ksh_option_print
# disown 后自动继续进程
setopt auto_continue
setopt extended_glob

# Disable tty flow control, allows vim to use '<Ctrl>S'
unsetopt flow_control && stty -ixon

# set tab size
tabs -4

# Others
autoload -Uz zmv
autoload -Uz zargs

bindkey -e
autoload -U edit-command-line
zle -N edit-command-line
bindkey "^x^e" edit-command-line

# set end of file mark
export PROMPT_EOL_MARK="⏎"

# Terminal Title
autoload -Uz add-zsh-hook

function set-xterm-terminal-title () {
    printf '\e]2;%s\a' "$@"
}

function precmd-set-terminal-title () {
    set-xterm-terminal-title "${(%):-"%n@%m: %~"}"
}

# function preexec-set-terminal-title () {
#     set-xterm-terminal-title "${(%):-"%n@%m: "}$2"
# }

if [[ "$TERM" == (screen*|xterm*|rxvt*|tmux*|putty*|konsole*|gnome*) ]]; then
    add-zsh-hook -Uz precmd precmd-set-terminal-title
    # add-zsh-hook -Uz preexec preexec-set-terminal-title
fi

if is-at-least 5.1; then
    # https://archive.zhimingwang.org/blog/2015-09-21-zsh-51-and-bracketed-paste.html
    autoload -Uz bracketed-paste-url-magic
    zle -N bracketed-paste bracketed-paste-url-magic
fi

# better than copy-prev-word
bindkey "^[^_" copy-prev-shell-word

autoload -Uz colors zsh/terminfo
colors

() {
    autoload -Uz colors && colors
    local white_b=$fg_bold[white] blue=$fg_bold[blue] rst=$reset_color
    local white_b=$'\e[97m' blue=$'\e[94m' rst=$'\e[0m'
    TIMEFMT=("== TIME REPORT FOR $white_b%J$rst =="$'\n'
        "  User: $blue%U$rst"$'\t'"System: $blue%S$rst  Total: $blue%*Es${rst}"$'\n'
        "  CPU:  $blue%P$rst"$'\t'"Mem:    $blue%M MiB$rst")
}

[[ "$COLORTERM" == (24bit|truecolor) || (( ${terminfo[colors]} == 16777216 )) ]] || zmodload zsh/nearcolor

# Basic LS_COLORS
(( $_in_gui == 1 )) || [[ -n $ANDROID_ROOT ]] || eval "$(dircolors -b)"

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# vim: ft=zsh sw=4 ts=8 sts=4 et:
