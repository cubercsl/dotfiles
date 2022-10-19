Jetpack 'tani/vim-jetpack', {'opt': 1} "bootstrap
Jetpack 'dracula/vim', {'as': 'dracula'}
Jetpack 'raimondi/delimitmate'
Jetpack 'tpope/vim-fugitive'
Jetpack 'tpope/vim-sensible'
Jetpack 'vim-airline/vim-airline'
Jetpack 'wakatime/vim-wakatime', {'opt': 1} "only load when wakatime installed

if executable('fcitx5-remote')
  let g:fcitx5_remote='fcitx5-remote'
  Jetpack 'lilydjwg/fcitx.vim', { 'branch': 'fcitx5'}
endif

" vim: ft=vim sw=2 ts=4 sts=2 fdm=marker fdl=1 et:

