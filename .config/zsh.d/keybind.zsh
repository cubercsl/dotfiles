# use emacs keybind
autoload -Uz terminfo

bindkey -e

typeset -A key=(
    Esc         '\e'
    Space       ' '
    Ctrl+Space  '^ '
    Alt+Space   '\e '
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
    Tab         "${terminfo[ht]}"
    Shift-Tab   "${terminfo[kcbt]}"
    Enter       "${terminfo[kent]}"
    Options     "${terminfo[kopt]}"
    F1          "${terminfo[kf0]}"
    F2          "${terminfo[kf0]}"
    F3          "${terminfo[kf0]}"
    F4          "${terminfo[kf0]}"
    F5          "${terminfo[kf0]}"
    F6          "${terminfo[kf0]}"
    F7          "${terminfo[kf0]}"
    F8          "${terminfo[kf0]}"
    F9          "${terminfo[kf0]}"
    F10         "${terminfo[kf0]}"
    F11         "${terminfo[kf0]}"
    F12         "${terminfo[kf0]}"
)

# these are from terminfo user_cap (man user_caps)
local -A _mods=(
    Shift               '2'
    Alt                 '3'
    Alt-Shift           '4'
    Ctrl                '5'
    Ctrl-Shift          '6'
    Ctrl-Alt            '7'
    Ctrl-Alt-Shift      '8'
    Meta                '9'
    Meta-Shift          '10'
    Meta-Alt            '11'
    Meta-Alt-Shift      '12'
    Meta-Ctrl           '13'
    Meta-Ctrl-Shift     '14'
    Meta-Ctrl-Alt       '15'
    Meta-Ctrl-Alt-Shift '16'
)

for k v in ${(kv)_mods}; do
    key[${k}-Up]="${terminfo[kUP${v}]}"
    key[${k}-Down]="${terminfo[kDN${v}]}"
    key[${k}-Left]="${terminfo[kLFT${v}]}"
    key[${k}-Right]="${terminfo[kRIT${v}]}"
    key[${k}-Home]="${terminfo[kHOM${v}]}"
    key[${k}-End]="${terminfo[kEND${v}]}"
    key[${k}-PageUp]="${terminfo[kPRV${v}]}"
    key[${k}-PageDown]="${terminfo[kNXT${v}]}"
    key[${k}-Delete]="${terminfo[kDC${v}]}"
    key[${k}-Insert]="${terminfo[kIC${v}]}"
done

for k in {A..Z} {0..9} '=' '*' '+' '-' '.' '/'; do
    key[${k:u}]="${k:u}"
    key[Ctrl-${k:u}]='^'"${k:u}"
    key[Alt-${k:u}]='\e'"${k:l}"
    key[Ctrl-Alt-${k:u}]='\e'"[6${k:u}"
    key[Alt-Shift-${k:u}]='\e'"${k:u}"
done

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
[[ -n "$key[Ctrl-Delete]" ]] && bindkey -- "$key[Ctrl-Delete]" kill-word
# [Ctrl-RightArrow] - move forward one word
[[ -n "$key[Ctrl-Right]"  ]] && bindkey -- "$key[Ctrl-Right]" forward-word
# [Ctrl-LeftArrow] - move backward one word
[[ -n "$key[Ctrl-Left]"   ]] && bindkey -- "$key[Ctrl-Left]" backward-word
# [Space] - don't do history expansion
[[ -n "$key[Space]"       ]] && bindkey -- "$key[Space]" magic-space

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey -- "$key[Ctrl-X]$key[Ctrl-E]" edit-command-line
# file rename magick
bindkey "^[m" copy-prev-shell-word


sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
    zle end-of-line                 #光标移动到行末
}
zle -N sudo-command-line
# [Esc] [Esc]
bindkey -- "$key[Esc]$key[Esc]" sudo-command-line

# vim: ft=zsh sw=4 ts=8 sts=4 et:
