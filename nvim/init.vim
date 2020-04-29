call plug#begin()
" Themes
Plug 'arcticicestudio/nord-vim'

" Plugins
Plug 'LnL7/vim-nix'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'vim-syntastic/syntastic'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'rust-lang/rust.vim'
Plug 'ledger/vim-ledger'
Plug 'majutsushi/tagbar'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
call plug#end()


" Make it less annoying
set showcmd
set showmode
set noerrorbells
set nobackup
set noswapfile
set backspace=indent,eol,start
set wildmode=longest,list,full
set hidden
set wildmenu
set hidden

" Make things pretty
syntax enable

color nord
let g:lightline = { "colorscheme" : 'nord'  }
set ruler
set number

" Feature Plugins

" Key maps
map <C-\> :NERDTreeToggle<CR>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

set rtp+=~/.fzf
map <C-p> :FZF<CR>

" Kind of need it on the iPad
imap jj <Esc>

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Language features

" General
set tabstop=4
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab
set ignorecase
set smartcase
set gdefault

" Ledger
let g:ledger_maxwidth = 80

" Rust
let g:rustfmt_autosave = 1
