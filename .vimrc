unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim
set number
set tabstop=4
set shiftwidth=4
set expandtab
" =================================================================================================
" download vim-plug if missing
if empty(glob("~/.vim/autoload/plug.vim"))
  silent! execute '!curl --create-dirs -fsSLo ~/.vim/autoload/plug.vim https://raw.fastgit.org/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * silent! PlugInstall
endif

" declare plugins
silent! if plug#begin()
  if filereadable(expand("~/.vimrc.plugins"))
    source ~/.vimrc.plugins
  endif
  call plug#end()
endif
" =================================================================================================
set shortmess=F
set noshowmode
silent! colorscheme dracula
let g:airline_theme='dracula'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#branch#enabled=1
let g:airline_powerline_fonts=1
