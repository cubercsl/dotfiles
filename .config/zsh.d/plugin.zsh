_enabled_plugins=(
    autopair
    command-not-found
    gnu-utils
    gpg-agent
    pyenv
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting
)

_ZSH_PLUGINS="/usr/share/zsh/plugins"
for _zsh_plugin in $_enabled_plugins[@]; do
    for file (
        $ZDOTDIR/plugins/$_zsh_plugin.plugin.zsh
        /usr/local/share/$_zsh_plugin/$_zsh_plugin.zsh  # macos homebrew
        $_ZSH_PLUGINS/$_zsh_plugin/$_zsh_plugin.zsh
    ); do
        if [[ -r "$file" ]]; then
            source "$file"
            break
        fi
    done
    unset file
done
unset _zsh_plugin _enabled_plugins
