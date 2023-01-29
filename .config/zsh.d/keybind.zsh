# use emacs keybind
bindkey -e

# https://wiki.archlinux.org/title/Zsh#Key_bindings
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key
key=(
    Home        "${terminfo[khome]}"
    End         "${terminfo[kend]}"
    Insert      "${terminfo[kich1]}"
    Backspace   "${terminfo[kbs]}"
    Delete      "${terminfo[kdch1]}"
    Up          "${terminfo[kcuu1]}"
    Down        "${terminfo[kcud1]}"
    Left        "${terminfo[kcub1]}"
    Right       "${terminfo[kcuf1]}"
    PageUp      "${terminfo[kpp]}"
    PageDown    "${terminfo[knp]}"
    Shift-Tab   "${terminfo[kcbt]}"
)

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

# [Ctrl-Delete] - delete whole forward-word
bindkey -- '^[[3;5~' kill-word
# [Ctrl-RightArrow] - move forward one word
bindkey -- '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey -- '^[[1;5D' backward-word

bindkey -- '\ew' kill-region                             # [Esc-w] - Kill from the cursor to the mark
bindkey -s '\el' 'ls\n'                                  # [Esc-l] - run command: ls
bindkey -- '^r' history-incremental-search-backward      # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
bindkey -- ' ' magic-space                               # [Space] - don't do history expansion

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey -- '\C-x\C-e' edit-command-line

# file rename magick
bindkey "^[m" copy-prev-shell-word


sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
    zle end-of-line                 #光标移动到行末
}
zle -N sudo-command-line
# [Esc] [Esc]
bindkey -- '\e\e' sudo-command-line

if (( $+commands[fzf] )); then
    source /usr/local/share/fzf/key-bindings.zsh 2>/dev/null || \
    source /usr/share/fzf/key-bindings.zsh 2>/dev/null
fi


# vim: ft=zsh sw=4 ts=8 sts=4 et:
