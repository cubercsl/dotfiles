# reload zsh
alias reload="sync && source $HOME/.zshrc && rehash"

(( $+commands[lsd] )) && alias ls='lsd'
alias l='ls -al'         # Lists in one column, hidden files.
alias ll='ls -lh'        # Lists human readable sizes.
alias lr='ll -R'         # Lists human readable sizes, recursively.
alias la='ll -A'         # Lists human readable sizes, hidden files.
alias lm='la | "$PAGER"' # Lists human readable sizes, hidden files through pager.
alias lx='ll -X'         # Lists sorted by extension (GNU only).
alias lk='ll -Sr'        # Lists sorted by size, largest last.
alias lt='ll -tr'        # Lists sorted by date, most recent last.
#alias lc='lt -c'         # Lists sorted by date, most recent last, shows change time.
#alias lu='lt -u'         # Lists sorted by date, most recent last, shows access time.

# bat using noexpandtab
(( $+commands[bat] )) && export BAT_OPTS="--tabs 0"

alias ..="cd .."

# add progress
alias dd='dd status=progress'
alias mv='mv -v'
alias rm='rm -v'

# pastebin 
alias pb='curl -F "c=@-" "http://fars.ee/"'

# Enable aliases to be sudo’ed
# http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias sudo='sudo '

# vim: ft=zsh sw=4 ts=8 sts=4 et:
