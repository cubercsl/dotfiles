for _zsh_plugin in $plugins[@]; do
    local _loaded=0
    for _file (
        $ZSHCONFIG/plugins/$_zsh_plugin/$_zsh_plugin{,.plugin}.zsh
        /usr{/local,}/share/$_zsh_plugin/$_zsh_plugin{,.plugin}.zsh
        /usr/share/zsh/plugins/$_zsh_plugin/$_zsh_plugin{,.plugin}.zsh
    ); do
        local plug_dir=${_file%/*}
        if [[ -r "$_file" ]]; then
            [[ -r $ZSHCONFIG/plugins/$_zsh_plugin/$_zsh_plugin.setting.zsh ]] &&\
                source $ZSHCONFIG/plugins/$_zsh_plugin/$_zsh_plugin.setting.zsh
            source "$_file"
            _loaded=1
            break
        fi
    done
    (( _loaded==0 )) && _cfg_warning "Can not load plugin \"$_zsh_plugin\"."
done
unset _file _zsh_plugins
# vim: ft=zsh sw=4 ts=8 sts=4 et:
