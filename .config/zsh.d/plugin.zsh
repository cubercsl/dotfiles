plugins=(
    colored-man-pages               local
    command-not-found               @omz/command-not-found
    dotenv                          @omz/dotenv
    fzf                             @omz/fzf
    gpg-agent                       @omz/gpg-agent
    zsh-autosuggestions             local
    zsh-history-substring-search    local
    zsh-autopair                    git+https://github.com/hlissner/zsh-autopair
    replace-multiple-dots           git+https://github.com/momo-lab/zsh-replace-multiple-dots
    fast-syntax-highlighting        git+https://github.com/zdharma-continuum/fast-syntax-highlighting    
)

function _download_plugin() {
    local _url=$1
    local _plugin=$2
    local _dir=$ZSHCONFIG/plugins/$_plugin

    if [[ $_url == "local" ]]; then
        _cfg_error "Plugin $_plugin is not available"
        return 1
    fi
    if [[ $_url == @omz/* ]]; then
        _url=https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/${_url#*@omz/}/$_plugin.plugin.zsh
    fi
    _cfg_info "Downloading $_plugin from $_url"
    if [[ -d $_dir ]]; then
        _cfg_warning "Plugin $_plugin already exists"
        return 1
    fi
    if [[ $_url == git+* ]]; then
        git clone --depth=1 ${_url#git+} $_dir || return 1
    else
        mkdir -p $_dir || return 1
        curl -sL $_url -o $_dir/$_plugin.plugin.zsh || return 1
    fi
}


for _zsh_plugin _url in ${(kv)plugins}; do
    local _loaded=0
    for _file (
        $ZSHCONFIG/plugins/$_zsh_plugin/{,zsh-}$_zsh_plugin{,.plugin}.zsh
        /usr{/local,}/share/$_zsh_plugin/$_zsh_plugin{,.plugin}.zsh
        /usr/share/zsh/plugins/$_zsh_plugin/$_zsh_plugin{,.plugin}.zsh
    ); do
        local plug_dir=${_file%/*}
        if [[ -r "$_file" ]]; then
            [[ -r $ZSHCONFIG/plugins/$_zsh_plugin.setting.zsh ]] &&\
                source $ZSHCONFIG/plugins/$_zsh_plugin.setting.zsh
            fpath+=($plug_dir)
            source "$_file"
            _loaded=1
            break
        fi
    done
    (( _loaded==0 )) && { 
        _download_plugin $_url $_zsh_plugin || _cfg_error "Failed to load $_zsh_plugin"
    }
done


unset _file _zsh_plugins _url _download_plugin _loaded
# vim: ft=zsh sw=4 ts=8 sts=4 et:
