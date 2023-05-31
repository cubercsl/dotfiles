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

# vim: ft=zsh sw=4 ts=8 sts=4 et:
