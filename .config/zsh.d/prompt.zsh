ZSH_THEME=powerlevel10k
for _file (
    $ZSHCONFIG/themes/$ZSH_THEME/$ZSH_THEME.zsh-theme
    /usr{/local,}/share/zsh-theme-$ZSH_THEME/$ZSH_THEME.zsh-theme
    /usr/share/zsh/themes/$ZSH_THEME/$ZSH_THEME.zsh-theme
); do
    if [[ -r "$_file" ]]; then
        source "$_file"
        break
    fi
done

if zmodload zsh/terminfo && (( terminfo[colors] >= 256 )); then
    # capable terminal
    [[ ! -f $ZSHCONFIG/p10k.zsh ]] || source $ZSHCONFIG/p10k.zsh
else
    # might be TTY or some other not very capable terminal
    [[ ! -f $ZSHCONFIG/p10k-portable.zsh ]] || source $ZSHCONFIG/p10k-portable.zsh
fi
# vim: ft=zsh sw=4 ts=8 sts=4 et:
