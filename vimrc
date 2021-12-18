if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plug')
Plug 'tpope/vim-surround'
Plug 'doums/darcula'
Plug 'ptzz/lf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'euclidianAce/BetterLua.vim'
Plug 'dense-analysis/ale'
Plug 'liuchengxu/vim-which-key'
Plug 'sudormrfbin/cheatsheet.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'cespare/vim-toml', { 'branch': 'main' }
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'SirVer/ultisnips'
Plug 'shougo/deoplete.nvim'
call plug#end()



" Basics
filetype on
syntax on
set number
let mapleader = "\<space>"
colorscheme darcula
set termguicolors
set clipboard+=unnamedplus

call darcula#Hi('LineNr', ['#606366', 145], ['#0B0B0B',235])
call darcula#Hi('Normal', ['#A9B7C6', 145], ['#000000',0])

" History/Buffers
set hidden
set history=100

" Formatting
filetype indent on
set tabstop=4
set softtabstop=4
set shiftwidth=4
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

" lf file manager
let g:lf_map_keys = 0
let g:lf_width = 0.9
let g:lf_height = 0.9
map <leader>f :LfCurrentFileNewTab<CR>
let g:lf_command_override = 'lf -command "set hidden" -config ~/.config/lf/lfrcvim'

" Tabs
nnoremap <silent> <leader><right> :tabn<CR>
nnoremap <silent> <leader><left> :tabp<CR>

" ALE

let g:ale_fixers = {
\   'lua': [
\       'lua-format',
\   ],
\   'json': ['jq'],
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\   'html': ['prettier'],
\}

nnoremap <leader>l :ALEFix<CR>

" Whichkey
"
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
nnoremap <leader>? :Cheatsheet<CR>

" Markdown

" disable header folding
let g:vim_markdown_folding_disabled = 1

" do not use conceal feature, the implementation is not so good
let g:vim_markdown_conceal = 0

" disable math tex conceal feature
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" support front matter of various format
let g:vim_markdown_frontmatter = 1  " for YAML format

" Use ripgrep for searching ⚡️
" Options include:
" --vimgrep -> Needed to parse the rg response properly for ack.vim
" --type-not sql -> Avoid huge sql file dumps as it slows down the search
" --smart-case -> Search case insensitive if all lowercase pattern, Search case sensitively otherwise
let g:rg_path = 'rg --vimgrep --type-not sql --smart-case'

" Maps <leader>/ so we're ready to type the search keyword
nnoremap <Leader>/ :Rg<Space>
" }}}

" Navigate quickfix list with ease
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>

" Markdown preview
let g:mkdp_browser = 'chromium'

let g:UltiSnipsExpandTrigger="<tab>"

