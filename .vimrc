call plug#begin('~/.vim/plugged')


Plug 'tomasiser/vim-code-dark'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

syntax on
set nu rnu
colorscheme codedark

" Set tab insert 4 spaces
set expandtab
set tabstop=4
set shiftwidth=4

:set hidden

map <C-n> :NERDTreeToggle<CR>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
