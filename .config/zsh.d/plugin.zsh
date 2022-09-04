_enabled_plugins=(
    autopair
    better-man-pages
    command-not-found
    dotenv
    gnu-utils
    gpg-agent
    grc
    pyenv
    # provided by package manager
    zsh-autosuggestions 
    zsh-history-substring-search
    zsh-syntax-highlighting
)

for _zsh_plugin in $_enabled_plugins[@]; do
    for _file (
        $ZDOTDIR/plugins/$_zsh_plugin.plugin.zsh
        /usr{/local,}/share/$_zsh_plugin/$_zsh_plugin.zsh  # macos homebrew
        /usr/share/zsh/plugins/$_zsh_plugin/$_zsh_plugin.zsh
    ); do
        if [[ -r "$_file" ]]; then
            source "$_file"
            break
        fi
    done
    unset _file
done
unset _zsh_plugin _enabled_plugins
# vim: ft=zsh sw=4 ts=8 sts=4 et:
