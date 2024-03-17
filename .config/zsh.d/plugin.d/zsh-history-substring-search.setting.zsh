### zsh-history-substring-search Setting

bindkey -- "$key[Up]" history-substring-search-up
bindkey -- "$key[Down]" history-substring-search-down
HISTORY_SUBSTRING_SEARCH_PREFIXED=true

# Number of entries to show (default is $LINES/3)
zstyle ":history-search-multi-word" page-size "7"
# Color in which to highlight matched, searched text (default bg=17 on 256-color terminals)
zstyle ":history-search-multi-word" highlight-color "fg=yellow,bold"
# Whether to perform syntax highlighting (default true)
zstyle ":plugin:history-search-multi-word" synhl "yes"
# Effect on active history entry. Try: standout, bold, bg=blue (default underline)
zstyle ":plugin:history-search-multi-word" active "underline"
# Whether to check paths for existence and mark with magenta (default true)
zstyle ":plugin:history-search-multi-word" check-paths "yes"
# Whether pressing Ctrl-C or ESC should clear entered query
zstyle ":plugin:history-search-multi-word" clear-on-cancel "no"

# vim: ft=zsh sw=4 ts=8 sts=4 et:
