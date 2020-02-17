set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Bundles!
Plugin 'a.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'gmarik/Vundle.vim'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'nanotech/jellybeans.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-sleuth'
Plugin 'tmhedberg/matchit'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-misc'
Plugin 'w0rp/ale'
Plugin 'Yggdroot/indentLine'

call vundle#end()

syntax on
set background=dark
set ruler                     " show the line number on the bar
set more                      " use more prompt
set autoread                  " watch for file changes
set relativenumber            " relative line numbers
set number                    " line numbers
set hidden
set noautowrite               " don't automagically write on :next
set lazyredraw                " don't redraw when don't have to
set showmode
set showcmd
set autoindent                " auto/smart indent
set smarttab                  " tab and backspace are smart
set expandtab                 " insert spaces instead of tabs
set tabstop=4                 " 4 spaces
set softtabstop=4             " 4 spaces
set shiftwidth=4              " 4 space tabs
set scrolloff=5               " keep at least 5 lines above/below
set sidescrolloff=5           " keep at least 5 lines left/right
set history=200
set backspace=indent,eol,start
set linebreak
set cmdheight=2               " command line two lines high
set undolevels=1000           " 1000 undos
set updatecount=100           " switch every 100 chars
set complete=.,w,b,u,U,t,i,d  " do lots of scanning on tab completion
set ttyfast                   " we have a fast terminal
set noerrorbells              " No error bells please
set shell=bash
set fileformats=unix
set ff=unix
set filetype=on               " Enable filetype detection
filetype indent on            " Enable filetype-specific indenting
filetype plugin on            " Enable filetype-specific plugins
set wildmode=longest:full
set wildmenu                  " menu has tab completion
let maplocalleader=','        " all my macros start with ,
set laststatus=2
set mouse=a
set t_Co=256

"  searching
set incsearch                 " incremental search
set ignorecase                " ignore case (see smartcase below)
set smartcase                 " ignore case unless user searches an [A-Z] char
set hlsearch                  " highlight the search
set showmatch                 " show matching bracket
set diffopt=filler,iwhite     " ignore all whitespace and sync

" Highlight trailing whitespace and lines too long
" This must run before the colorscheme
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"  backup
set backup
silent !mkdir ~/.vim_backup > /dev/null 2>&1
set backupdir=~/.vim_backup
set viminfo=%100,'100,/100,h,\"500,:100,n~/.viminfo

" Reopen files at the same line we exited from last time
if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
		\| exe "normal! g'\"" | endif
endif

" mappings
" toggle list mode
nmap <LocalLeader>tl :set list!<cr>
" toggle paste mode
nmap <LocalLeader>pp :set paste!<cr>

" Highlight tab character in red
syn match tab display "\t"
hi link tab Error

" Make line wrapping work as expected
noremap <buffer> <silent> k gk
noremap <buffer> <silent> j gj

" Map folding to the spacebar
nnoremap <space> za
vnoremap <space> zf

" Pretty colors!
colorscheme jellybeans

" Simple tab completion
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

inoremap jk <ESC>

noremap <F2> <Esc>:syntax sync fromstart<CR>
inoremap <F2> <C-o>:syntax sync fromstart<CR>

map <C-g> :NERDTreeToggle<CR>

" Statusline
set statusline=%f       "relative path to the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
highlight StatusLine ctermbg=black ctermfg=white

" Colorcolumn settings
set colorcolumn=81
highlight ColorColumn ctermbg=darkred guibg=darkred
" Path-specific colorcolumn
autocmd BufRead,BufNewFile *.java setlocal colorcolumn=121
autocmd BufRead,BufNewFile /data/users/gorel/fbcode/dataswarm-pipelines/* setlocal colorcolumn=101

" Support folding in Python
autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<
set foldlevel=99

" Filetype-specific settings
autocmd FileType css setlocal shiftwidth=2 softtabstop=2
autocmd FileType html set textwidth=0
autocmd FileType html setlocal shiftwidth=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2
autocmd BufRead,BufNewFile *.cconf setfiletype python
autocmd BufRead,BufNewFile *.cinc setfiletype python

" autocomplete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#Complete
autocmd FileType html set omnifunc=htmlcomplete#Complete
autocmd FileType css set omnifunc=csscomplete#Complete
autocmd FileType xml set omnifunc=xmlcomplete#Complete
autocmd FileType php set omnifunc=phpcomplete#Complete
autocmd FileType c set omnifunc=ccomplete#Complete

" Buffers - explore/next/previous
nnoremap <silent> B :BufExplorer<CR>
nnoremap <silent> bn :bn<CR>
nnoremap <silent> bp :bp<CR>

" Custom functions
function Copy()
	if (&number == 1)
		set nonumber
		set norelativenumber
		set paste
		set mouse=""
	else
		set number
		set relativenumber
		set nopaste
		set mouse=a
	endif
endfunction
