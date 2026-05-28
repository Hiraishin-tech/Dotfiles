syntax on
" Mapping leader key as space
let mapleader = " "

" Enable filetype detection, plugins, and indenting
filetype plugin indent on

" Display line numbers, relative number and the current cursor line
set number
set relativenumber
set cursorline

" Colorshemes:
" colorscheme gruvbox
colorscheme catppuccin

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

" Mouse support
set mouse=a
" set mouse=nv " only in normal and visual mode

" Move selected lines up and down with J and K in Visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Keep selection after indenting with < or >
vnoremap < <gv
vnoremap > >gv

" Duplicate lines
" vnoremap <Esc>d y'>p
" This will after duplicating the selected lines highlight the duplicated text again
vnoremap <Esc>d y'>p`[V`]
nnoremap <Esc>d yyp

" Clipboard support
set clipboard+=unnamedplus

" Cltr + backspace deletes the whole word in insert mode
inoremap <C-H> <C-w>



" Netrw better config, set number, set relativenumber etc.
let g:netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'

" Plugins:
call plug#begin()
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-commentary'
Plug 'yegappan/lsp'
Plug 'jasonccox/vim-wayland-clipboard'
Plug 'catppucin/vim'
" Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
call plug#end()

" Highlight duration
let g:highlightedyank_highlight_duration = 200

"Git support
let g:gitgutter_enabled = 1
let g:gitgutter_signs = 1
nnoremap <leader>gp <Plug>(GitGutterPreviewHunk)
nnoremap <leader>gs <Plug>(GitGutterStageHunk)
nnoremap <leader>gr <Plug>(GitGutterUndoHunk)

nnoremap <leader>lg <cmd>!lazygit<cr>

""""""""""""""" LSP config:""""""""""""""""""""""""""""""""""""""""
set updatetime=300
set signcolumn=yes
let g:lspOpts = #{
    \ autoHighlightDiags: v:true,
    \ showDiagWithVirtualText: v:false,
    \ showSignature: v:true,
    \ popupBorder: v:true,
    \ semanticHighlight: v:true,
    \ autoComplete: v:true,
    \}
autocmd User LspSetup call LspOptionsSet(g:lspOpts)
" autocmd CursorHold * call s:ShowLspDiag() " popup dialog shows up, can be
" annoying

" Shows whats the error in the current line
nnoremap <leader>er <cmd>LspDiag current<cr>

function! s:ShowLspDiag()
    silent! LspDiag current
endfunction

" Arduino LSP doesn't work for now
let s:arduino_args = [
    \ '-clangd', expand('clangd'),
    \ '-cli', expand('arduino-cli'),
    \ '-cli-config', expand('~/.arduino15/arduino-cli.yaml'),
    \ '-fqbn', 'arduino:avr:mega'
    \ ]

let g:lspServers = [
    \ #{
	\	  name: 'clang',
	\	  filetype: ['c', 'cpp'],
	\	  path: 'clangd',
	\	  args: ['--background-index']
	\ },
    \ #{
    \     name: 'basedpyright',
    \     filetype: ['python'],
    \     path: 'basedpyright-langserver',
    \     args: ['--stdio'],
    \ },
    \ #{
    \     name: 'typescriptlang',
	\     filetype: ['javascript', 'typescript'],
	\     path: 'typescript-language-server',
	\     args: ['--stdio'],
    \ },
    \ #{
    \     name: 'arduino',
	\     filetype: ['arduino'],
	\     path: 'arduino-language-server',
    \     args: s:arduino_args,
    \ },
    \ #{
    \     name: 'bash',
	\     filetype: ['sh'],
	\     path: 'bash-language-server',
	\     args: ['start'],
    \ },
    \ #{
    \     name: 'vim',
	\     filetype: ['vim'],
	\     path: 'vim-language-server',
	\     args: ['--stdio'],
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
nnoremap qf <cmd>LspCodeAction<cr>
nnoremap <leader>fa <cmd>LspFixAll<cr>

nnoremap <leader>rn <cmd>LspRename<cr>

" nnoremap [d <cmd>LspDiag prev<cr>
" nnoremap ]d <cmd>LspDiag next<cr>

" Going to the Explorer mode
nnoremap - <cmd>Ex<cr>
nnoremap <leader>es <cmd>Lexplore<cr>
nnoremap <leader>ex <cmd>Lexplore<cr>
nnoremap <leader>tn <cmd>tabnew<cr>
" nnoremap <leader>f <cmd>botright term<cr>
" nnoremap <Esc>f <cmd>botright term<cr>

" Navigation through ctrl + navigation key
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j   

" Brackets completion, smart pairs etc.
inoremap { {}<Esc>ha
inoremap ( ()<Esc>ha
inoremap [ []<Esc>ha
inoremap " ""<Esc>ha
inoremap ' ''<Esc>ha
inoremap ` ``<Esc>ha

" Smart Enter inside {}
inoremap {<CR> {}<Esc>i<CR><Esc>O

" Remove highlighted text by pressing Esc key
nnoremap <silent> <Esc> :nohlsearch<CR><Esc>

set completeopt=menuone,popup
set termguicolors
" Cursor config
" let &t_SI = "\e[6 q"  " Insert mode: vertical beam
" let &t_EI = "\e[2 q"  " Normal mode: solid block

let g:terminal_ansi_colors = [
    \ '#282828', '#cc241d', '#98971a', '#d79921',
    \ '#458588', '#b16286', '#689d6a', '#d65d0e',
    \ '#7c6f64', '#928374', '#928374', '#7c6f64',
    \ '#928374', '#928374', '#928374', '#ebdbb2'
\ ]

" Color Themes:
set background=dark

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

" Netrw configuration:
let g:netrw_winsize = 22
let g:netrw_banner = 0 " shift + i to show the banner
let g:netrw_localcopydircmd = 'cp -r' " Enabling recursive copy of the directories
let g:netrw_keepdir = 0
hi! link netrwMarkFile Search

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
" navigation
  nmap <buffer> H -
  nmap <buffer> L <CR>

  " window navigation
  nnoremap <buffer> <C-h> <C-w>h
  nnoremap <buffer> <C-l> <C-w>l
  nnoremap <buffer> <C-j> <C-w>j
  nnoremap <buffer> <C-k> <C-w>k
  
" Mark files
  nmap <buffer> <TAB>   mf
  nmap <buffer> <S-TAB> mF
  nmap <buffer> u       mu

" Copying / move
  nmap <buffer> yy mf
  " p copy to the selected directory
  " P move to the selected directory
  nmap <buffer> p  mtmc
  nmap <buffer> P  mtmm
  " r for renaming a file
  nmap <buffer> r  R
  " Delete (including non-empty directories)
  nmap <buffer> D  :call NetrwRemoveRecursive()<CR>
  nmap <buffer> a %

  " Unmark all
  nmap <buffer> u mu

  " Info
  nmap <buffer> fl :echo join(netrw#Expose("netrwmarkfilelist"), "\n")<CR>
  nmap <buffer> fq :echo 'Target: ' . netrw#Expose("netrwmftgt")<CR>
endfunction
function! NetrwRemoveRecursive()
  if &filetype ==# 'netrw'
    cnoremap <buffer> <CR> rm -r<CR>
    normal mu
    normal mf
    try
      normal mx
    catch
      echo "Canceled"
    endtry
    cunmap <buffer> <CR>
  endif
endfunction

" Terminal mode config
hi Terminal guifg=#ffffff guibg=#000000
tnoremap <C-h> <C-w>h
tnoremap <C-j> <C-w>j
tnoremap <C-k> <C-w>k
tnoremap <C-l> <C-w>l

nnoremap <Esc>f :call TermToggle()<CR>
tnoremap <Esc>f <C-w>:call TermToggle()<CR>
" There is a weird bug if the netrw won't be closed first, then it
" would send infinite loop for exit.
tnoremap <C-d> <C-w>:call CloseNetrwAndExit()<CR>

function! CloseNetrwAndExit()
  for w in range(winnr('$'), 1, -1)
    if getbufvar(winbufnr(w), '&filetype') == 'netrw'
      "Closes the netrw window, :Lexplore
      execute w . 'wincmd w'
      close
      break
    endif
  endfor
  " Goes down to the terminal again via ctrl+d closes the terminal window
  wincmd j
  call term_sendkeys(bufnr('%'), "\<C-d>")
endfunction

function! TermToggle()
  for buf in tabpagebuflist()
    if getbufvar(buf, '&buftype') == 'terminal'
      hide
      return
    endif
  endfor
  for buf in range(1, bufnr('$'))
    if getbufvar(buf, '&buftype') == 'terminal' && buflisted(buf)
      botright sb
      execute 'buffer' buf
      return
    endif
  endfor
  botright terminal
endfunction

" nnoremap <leader>gw :vimgrep // **/*<Left><Left><Left><Left><Left><Left>
" Grepping in the whole project 
let g:start_dir = getcwd()
nnoremap <leader>gw :execute 'vimgrep //gj ' . g:start_dir . '/**/*'<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
" Visually selecting the text first, then grep it in the whole project
vnoremap <leader>gw y:vimgrep /<C-r>"/gj <C-r>=g:start_dir<CR>/**/*
" Opening quick fix list
nnoremap <leader>co :copen<cr>
nnoremap <leader>cc :cclose<cr>
nnoremap <leader>cn :cnext<cr>
nnoremap <leader>cp :cprev<cr>
