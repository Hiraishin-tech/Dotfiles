syntax on
" Mapping leader key as space
let mapleader = " "

" Enable filetype detection, plugins, and indenting
filetype plugin indent on

" Display line numbers, relative number and the current cursor line
set number
set relativenumber
" set cursorline

" Search settings: case-insensitive unless capital letters are used
set incsearch
set ignorecase
set smartcase
set hlsearch

" Formatting and Indentation
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

" Move selected lines up and down with J and K in Visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Keep selection after indenting with < or >
vnoremap < <gv
vnoremap > >gv

" Clipboard support
set clipboard+=unnamedplus

" Cltr + backspace deletes the whole word in insert mode
inoremap <C-H> <C-w>


" Plugins:
call plug#begin()
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-commentary'
Plug 'yegappan/lsp'
Plug 'jasonccox/vim-wayland-clipboard'
Plug 'catppucin/vim'
" Plug 'morhetz/gruvbox'
call plug#end()

" Highlight duration
let g:highlightedyank_highlight_duration = 200

""""""""""""""" LSP config:""""""""""""""""""""""""""""""""""""""""
let g:lspOpts = #{
    \ autoHighlightDiags: v:true,
    \ showDiagWithVirtualText: v:true,
    \ showSignature: v:true,
    \ popupBorder: v:true,
    \ semanticHighlight: v:true,
    \ autoComplete: v:true,
    \}
autocmd User LspSetup call LspOptionsSet(g:lspOpts)

let g:lspServers = [
    \ #{
	\	  name: 'clang',
	\	  filetype: ['c', 'cpp'],
	\	  path: 'clangd',
	\	  args: ['--background-index']
	\ },
    \ ]
autocmd User LspSetup call LspAddServer(g:lspServers)
""""""""""""""" END OF LSP config:""""""""""""""""""""""""""""""""""""""""

" keymaps:
nnoremap gd <cmd>LspGotoDefinition<cr>
nnoremap gD <cmd>LspGotoDeclaration<cr>
nnoremap gr <cmd>LspShowReferences<cr>
nnoremap gi <cmd>LspGotoImpl<cr>

nnoremap K  <cmd>LspHover<cr>

nnoremap <leader>rn <cmd>LspRename<cr>
nnoremap <leader>ca <cmd>LspCodeAction<cr>

" nnoremap [d <cmd>LspDiag prev<cr>
" nnoremap ]d <cmd>LspDiag next<cr>

" Going to the Explorer mode
nnoremap - <cmd>Ex<cr>
nnoremap <leader>tn <cmd>tabnew<cr>
nnoremap <leader>f <cmd>terminal<cr>

set completeopt=menuone,popup
set termguicolors
" Color Themes:
set background=dark

" Colorshemes:
" colorscheme gruvbox
colorscheme catppuccin

" Tab for selecting the first autocompletion option
inoremap <expr> <Tab> pumvisible()
    \ ? complete_info()['selected'] == -1
    \   ? "\<C-n>\<C-y>"
    \   : "\<C-y>"
    \ : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<BS>"

" Better completion menu colors
highlight Pmenu guibg=#1e1e2e guifg=#e6e6e6
highlight PmenuSel guibg=#3b82f6 gui=bold
highlight PmenuSbar guibg=#2a2a37
highlight PmenuThumb guibg=#6aa9ff
highlight PmenuKind guifg=#9EDe72
highlight PmenuKindSel guifg=#ffffff gui=bold
highlight PmenuExtra guifg=#c678dd
highlight PmenuExtraSel guifg=#ffffff gui=bold
