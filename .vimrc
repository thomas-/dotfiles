" tuomas.co.uk

set t_Co=256 "256 colors
set nocompatible

" source ~/.vim/bundles.vim

syntax on
set modelines=0		" security

" leader key
" by default is \
"let mapleader = "\"

" tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" 'coming home to vim' settings
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber

" backups/swap/undo and files
"set dir=~/.vim/tmp//
"set undodir=~/.vim/tmp//
"set undofile
"set backupdir=~/.vim/tmp//
"set backup

" search settings
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
"nnoremap <tab> %
"vnoremap <tab> %

" lines/wrappin
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=0

" make j/k/arrows use screen line not file line
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" disable help
"inoremap <F1> <ESC>
"nnoremap <F1> <ESC>
"vnoremap <F1> <ESC>

" map ; to :
nnoremap ; :
" quick escape
inoremap jj <ESC>

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
"color Tomorrow-Night-Bright
color Tomorrow-Night

" switching between windows by maximizing
set winminheight=0	" windows can be squished
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_

map Q gq

" map to switch tabs
map <F5> :tabp<cr>
map <F6> :tabn<cr>


" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


" leader key shortcuts
nnoremap <leader>ft Vatzf

