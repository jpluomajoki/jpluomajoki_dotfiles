"""" Plug """
call plug#begin('~/.vim/plugged')

Plug 'tomasiser/vim-code-dark'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'luochen1990/rainbow'

"--- Shamelessly copied from matsuuu
"--- Functional
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do' : { -> fzf#install() }}
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-gitgutter'

"--- Theming
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

"--- Markdown
"Plug 'godlygeek/tabular'
"Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app & yarn install' }

"--- Clojure
Plug 'Olical/conjure'

"-- Sexp
Plug 'guns/vim-sexp'

call plug#end()
""""""""""""""


""" Styles """

colorscheme gruvbox
let g:airline#extensions#tabline#enabled = 1

""""""""""""""

""" Set stuff """

set termguicolors
syntax on
set backspace=indent,eol,start
set nocompatible
set nohlsearch
set ruler
set number
set nowrap
set showcmd
set incsearch
set noswapfile
set autoread
set ignorecase
set smartcase
set noerrorbells
set expandtab
set cursorline
set backupcopy=yes
set relativenumber
set signcolumn=yes
set scrolloff=8
set hidden
hi LinrNr term=NONE
filetype plugin indent on
let g:loaded_matchparen=1
set encoding=UTF-8
set wrap
set linebreak

"""""""""""""""""

""" Leader to space """

let mapleader = " "
let maplocalleader = " "


"""""""""""""""""""""""


""" Mappings """

"FZF
nnoremap <silent><leader>q :bp<CR>
nnoremap <silent><leader>n :Files<CR>
nnoremap <leader>f :Rg<CR>

" NERDTree
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-n> :NERDTree<CR>

" Moving between splits
nnoremap <leader>h <C-W><C-H>
nnoremap <leader>j <C-W><C-J>
nnoremap <leader>k <C-W><C-K>
nnoremap <leader>l <C-W><C-L>

""""""""""""""""
