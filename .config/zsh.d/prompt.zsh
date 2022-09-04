if  command -v starship 2>&1 >/dev/null; then
    eval "$(starship init zsh)"
else
    _cfg_error "Install starship for prompt."
fi

# vim: ft=zsh sw=4 ts=8 sts=4 et:
