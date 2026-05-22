syntax on

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

" Highlight yanked text
" augroup HighlightYank
"   autocmd!
"   autocmd TextYankPost * call s:highlight_yank()
" augroup END
" 
" function! s:highlight_yank() abort
"   if v:event.operator ==# 'y'
"     let l:pos = getpos("'<"), getpos("'>")
"     call matchadd('IncSearch', \".\\\\%>'\\[\\\\_.*\\\\%<']..\")
"     call timer_start(500, 'matchdelete')
"   endif
" endfunction
