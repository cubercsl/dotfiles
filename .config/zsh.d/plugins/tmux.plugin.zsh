autoload -Uz zsh/terminfo

local -a cmds=()
if (( terminfo[colors] >= 256 )); then
    cmds+=(set -g default-terminal tmux-256color ';')
    if [[ $COLORTERM == (24bit|truecolor) ]]; then
        # https://github.com/romkatv/zsh4humans/commit/6b30738bd30da18273c2af53a37f699383d79b53
        cmds+=(set -ga terminal-features ',*:RGB:usstyle:overline' ';')
    fi
else
    #cmds+=(set -g default-terminal screen ';')
fi

function tmux () {
    if (( $#@ == 0 )); then
        command tmux "${cmds[@]}" new
    else
        command tmux "${cmds[@]}" $@
    fi
}

# vim: ft=zsh sw=4 ts=8 sts=4 et:
