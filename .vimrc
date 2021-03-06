" tuomas.co.uk

" plugins
call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'mihaifm/bufstop'
" Plug 'scrooloose/syntastic'
" Plug 'wookiehangover/jshint.vim'
" Plug 'Shutnik/jshint2.vim'
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
" Plug 'ternjs/tern_for_vim'
" Plug 'mustache/vim-mustache-handlebars'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tomtom/tcomment_vim'
" Plug 'vim-scripts/PreserveNoEOL' " preseves broken files so that people don't complain about diffs
call plug#end()

" work only
" let g:PreserveNoEOL = 1     " preseves broken files so that people don't complain about diffs

set t_Co=256                " 256 colors
set encoding=utf-8          " unicode encoding
set nocompatible            " dont be vi compatible
syntax enable               " enable syntax processing
set modelines=0             " security

" leader setting
let mapleader=","               " leader is comma

" color scheme
color Tomorrow-Night        " 

" tab settings
set tabstop=4               " visual spaces per tab
set shiftwidth=4            " size of a <TAB> character
set softtabstop=4           " number of spaces per tab
set expandtab               " insert spaces when pressing tab

" ui
set scrolloff=5             " keep X lines visible when scrolling
set autoindent              " auto indent when editing
set nocindent                   " ? fixes bad indenting?
set nosmartindent               " ? fixes bad indenting?
set showmatch               " highlight matching parens
set showmode                " show editor mode in bottom bar
set showcmd                 " show command in bottom bar
set hidden                  " hide files (as buffer) when opening new file
set wildmenu                " visual autocomplete of command menu
"set wildmode=list:longest  " styling for wildmenu
set visualbell              " visual bell
set cursorline              " highlight current line
set lazyredraw              " redraw only when we need to.
set ttyfast                 " performance
set ruler                   " current position in bottom line
set backspace=indent,eol,start " allow backspace to traverse indents, eols, starts
set laststatus=2            " always show statusline
"set relativenumber          " show relative line numbers
set number                  " show line numbers
set history=50          	" keep 50 lines of command line history

" folds
set foldenable              " enable folds
set foldlevelstart=99       " dont fold by default
set foldnestmax=10          " max 10 nested folds
set foldmethod=syntax       " fold based on syntax

" make j/k/arrows use screen line not file line
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" map ; to :
"nnoremap ; :
" quick escape
inoremap jj <ESC>

" search settings
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set hlsearch
nnoremap <silent> \ :noh<cr>
nnoremap <silent> <leader><space> :noh<cr>
"nnoremap <tab> %
"vnoremap <tab> %

" highlight last inserted text
nnoremap gV `[v`]

" toggle NERDTree
map <F2> :NERDTreeToggle<CR>
nmap <leader>m :NERDTreeToggle<CR>
" reveal current file in NERDTree
nmap <leader>n :NERDTreeFind<CR>
" change directory for current window to current file location
nnoremap <leader>cd :lcd %:p:h<CR>
" search current working directory for word under cursor
map <F4> :execute " grep -srnw --binary-files=without-match --exclude-dir=.git . -e " . expand("<cword>") . " " <bar> cwindow<CR>

" switching between windows by maximizing
set winminheight=0	" windows can be squished
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_

" toggle paste/nopaste
set pastetoggle=<leader>z

" tab navigation
" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>
" Go to last active tab
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
vnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>

" allow quit via single keypress (Q)
map Q :qa<CR>

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" leader key shortcuts
" toggle folds
nnoremap <leader>ft Vatzf
nnoremap <leader>b :BufstopFast<cr>
nnoremap <leader>g :!fossil diff<cr>

" leader d to delete without replacing copy register etc
nnoremap <leader>d "_d
vnoremap <leader>d "_d
vnoremap <leader>p "_dP

" surround line in "'s and <p> for quick convert from pasted docs to HSVT paragraph
nmap <leader>p yss<p>ysit"

" language specific settings
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType html setlocal tabstop=2
    autocmd FileType html setlocal shiftwidth=2
    autocmd FileType html setlocal softtabstop=2
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    autocmd BufEnter *.hsvt setlocal filetype=html
    autocmd BufEnter *.json setlocal ft=javascript
    autocmd BufEnter *.json setlocal tabstop=2
    autocmd BufEnter *.json setlocal shiftwidth=2
    autocmd BufEnter *.json setlocal softtabstop=2
    autocmd FileType crontab setlocal nowritebackup
augroup END

" backups
set backup
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//
set writebackup

" functions
" ---------
" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
"function! <SID>StripTrailingWhitespaces()
"    " save last search & cursor position
"    let _s=@/
"    let l = line(".")
"    let c = col(".")
"    %s/\s\+$//e
"    let @/=_s
"    call cursor(l, c)
"endfunction

function! NumberToggle()
    if(&relativenumber == 1)
        set number
    else
        set relativenumber
    endif
endfunc
nnoremap <leader>l :call NumberToggle()<cr>

" plugin settings
" ---------------
" CtrlP settings
nnoremap <D-t> :CtrlP<CR>
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
"let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" airline settings
let g:airline_powerline_fonts=1
let g:airline#extensions#whitespace#enabled = 0

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['html', 'xml'] }

" jshint2
let jshint2_read = 1
let jshint2_save = 1

" vimdiff colors
" --------------
highlight DiffAdd    cterm=bold ctermfg=7 ctermbg=22 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=52 ctermbg=88 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=7 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=7 ctermbg=89 gui=none guifg=bg guibg=Red

