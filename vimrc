if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plug')
Plug 'tpope/vim-surround'
call plug#end()

" Basics
filetype on
syntax on
set number
colorscheme darcula

" History/Buffers
set hidden
set history=100

" Formatting
filetype indent on
set tabstop=4
set softtabstop=4
set expandtab

" Search
set incsearch
set hlsearch

" Other
set wildmenu
set lazyredraw
set showmatch

" Mapping
" Clear search results
nnoremap <leader><space> :nohlsearch<CR> 
