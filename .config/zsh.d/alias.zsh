# reload zsh
alias reload="sync && exec zsh"

# using exa instead of ls, and ls' alias
if (( $+commands[exa] )); then
    alias ls='exa --time-style=long-iso --group --group-directories-first --header --git'
else
    alias ls='ls --color=auto --human-readable --time-style=long-iso --hyperlink=auto'
fi
alias l='ls -al'         # Lists in one column, hidden files.
alias ll='ls -lh'        # Lists human readable sizes.
alias lr='ll -R'         # Lists human readable sizes, recursively.
alias la='ll -A'         # Lists human readable sizes, hidden files.
alias lm='la | "$PAGER"' # Lists human readable sizes, hidden files through pager.
alias lx='ll -XB'        # Lists sorted by extension (GNU only).
alias lk='ll -Sr'        # Lists sorted by size, largest last.
alias lt='ll -tr'        # Lists sorted by date, most recent last.
alias lc='lt -c'         # Lists sorted by date, most recent last, shows change time.
alias lu='lt -u'         # Lists sorted by date, most recent last, shows access time.

# add progress
alias dd='dd status=progress'
alias mv='mv -v'
alias rm='rm -v'

# rsync
alias rsync-copy="rsync -avz --progress -h"
alias rsync-move="rsync -avz --progress -h --remove-source-files"
alias rsync-update="rsync -avzu --progress -h"
alias rsync-synchronize="rsync -avzu --delete --progress -h"

# pastebin 
alias pb='curl -F "c=@-" "http://fars.ee/"'

# Enable aliases to be sudo’ed
# http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias sudo='sudo '

# vim: ft=zsh sw=4 ts=8 sts=4 et:
