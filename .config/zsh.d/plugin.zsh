ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

plugins=(
    # theme
    romkatv/powerlevel10k

    OMZP::command-not-found
    OMZP::dotenv
    OMZP::fzf
    hlissner/zsh-autopair
    momo-lab/zsh-replace-multiple-dots
    zsh-users/zsh-history-substring-search
    zsh-users/zsh-autosuggestions
    zdharma-continuum/fast-syntax-highlighting
)

for plugin in $ZSHCONFIG/plugins/*.plugin.zsh; do
    plugins+=(is-snippet $plugin)
done

zinit light-mode for $plugins[@]

# load the gpg-agent plugin only if we are not in an ssh session
if (( _in_ssh == 0 )); then
    zinit for OMZP::gpg-agent
fi

for setting in $ZSHCONFIG/plugin.d/*.setting.zsh; do
    [ -r "$setting" ] && source $setting
done

# vim: ft=zsh sw=4 ts=8 sts=4 et:
