unlet! skip_defaults_vim
runtime defaults

if &compatible
    set nocompatible
endif

" =================================================================================================
" download vim-plug if missing
if empty(glob("~/.vim/autoload/plug.vim"))
  silent! execute '!curl --create-dirs -fsSLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * silent! PlugInstall --sync | source $MYVIMRC
endif

" declare plugins
silent! if plug#begin()
  if filereadable(expand("~/.vimrc.plugins"))
    source ~/.vimrc.plugins
  endif
  call plug#end()
endif
" =================================================================================================
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
if !has('termguicolors') || exists('$TMUX')
  let g:dracula_italic = 0
endif

set mouse=a
set number
set tabstop=4
set shiftwidth=4
set expandtab
set shortmess=F
set noshowmode
silent! colorscheme dracula

let g:airline_theme='dracula'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#branch#enabled=1
let g:airline_powerline_fonts=1
