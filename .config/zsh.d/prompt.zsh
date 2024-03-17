if zmodload zsh/terminfo && (( terminfo[colors] >= 256 )); then
    # capable terminal
    [[ ! -f $ZSHCONFIG/prompt.d/p10k.zsh ]] || source $ZSHCONFIG/prompt.d/p10k.zsh
else
    # might be TTY or some other not very capable terminal
    [[ ! -f $ZSHCONFIG/prompt.d/p10k-portable.zsh ]] || source $ZSHCONFIG/prompt.d/p10k-portable.zsh
fi
# vim: ft=zsh sw=4 ts=8 sts=4 et:
