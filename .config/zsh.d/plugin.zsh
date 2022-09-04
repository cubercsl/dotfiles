_enabled_plugins=(
    autopair                    # hlissner/zsh-autopair
    better-man-pages            # CoelacanthusHex/dotfiles
    command-not-found           # omz/plugins/command-not-found
    dotenv                      # omz/plugins/dotenv
    gnu-utils                   # omz/plugins/gnu-utils
    gpg-agent                   # omz/plugins/gpg-agent
    grc                         # /etc/grc.zsh
    pyenv                       # omz/plugin/pyenv
    zsh-replace-multiple-dots   # momo-lab/zsh-replace-multiple-dots
    # provided by package manager
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting
)

for _zsh_plugin in $_enabled_plugins[@]; do
    __loaded=0
    for _file (
        $ZDOTDIR/plugins/$_zsh_plugin.plugin.zsh
        /usr{/local,}/share/$_zsh_plugin/$_zsh_plugin.zsh
        /usr/share/zsh/plugins/$_zsh_plugin/$_zsh_plugin.zsh
    ); do
        if [[ -r "$_file" ]]; then
            source "$_file"
            __loaded=1
            [[ -r $ZDOTDIR/settings/$_zsh_plugin.setting.zsh ]] &&\
                source $ZDOTDIR/settings/$_zsh_plugin.setting.zsh
            break
        fi
    done
    (( __loaded==0 )) && _cfg_warning "Can not load plugin \"$_zsh_plugin\"." 
    unset _file __loaded
done
unset _zsh_plugin _enabled_plugins
# vim: ft=zsh sw=4 ts=8 sts=4 et:
