if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plug')

" Basics

Plug 'tpope/vim-surround'
Plug 'doums/darcula'

" Snippets

Plug 'SirVer/ultisnips'

" Windows and popups

Plug 'voldikss/vim-floaterm'
Plug 'ptzz/lf.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'

" Help and finding

Plug 'liuchengxu/vim-which-key'
Plug 'sudormrfbin/cheatsheet.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Formatting

Plug 'sbdchd/neoformat'

" LSP and completion

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

" Languages

Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

Plug 'cespare/vim-toml', { 'branch': 'main' }

Plug 'euclidianAce/BetterLua.vim'

Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }


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

" Formatting

nnoremap <leader>l :Neoformat<CR>

let g:neoformat_enabled_css = [ 'prettier' ]


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
nnoremap <Leader>/ :Rg<CR>
" }}}

" Navigate quickfix list with ease
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>

" Markdown preview
let g:mkdp_browser = 'chromium'

let g:UltiSnipsExpandTrigger="<tab>"

" nvim-cmp completion
set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['cssls'].setup {
    capabilities = capabilities
  }
EOF
