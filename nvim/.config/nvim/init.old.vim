set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set textwidth=120
set t_Co=256
syntax on
set number
set showmatch
inoremap {<CR> {<CR>}<C-o>O
"imap fd <Esc>
set splitright
set clipboard=unnamedplus

"Plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-commentary'
Plug 'ThePrimeagen/vim-be-good'
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-surround'

call plug#end()

