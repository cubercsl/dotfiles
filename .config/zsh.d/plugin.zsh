_enabled_plugins=(
    autopair
    command-not-found
    gnu-utils
    gpg-agent
    pyenv
)

for _zsh_plugin in $_enabled_plugins[@]; do
    [[ ! -r "$ZDOTDIR/plugins/$_zsh_plugin.plugin.zsh" ]] || source $ZDOTDIR/plugins/$_zsh_plugin.plugin.zsh
done
unset _enabled_plugins
