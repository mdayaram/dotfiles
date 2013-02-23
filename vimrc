set nocompatible

" Vundle setup
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Bundle 'gmarik/vundle'

" My Bundles
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
"Bundle 'scrooloose/syntastic'
Bundle 'tdesikan/vim-tritium'


" Basic options -------------------------
set encoding=utf-8
set modelines=0
set autoindent
set showmode
set showcmd
set hidden
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set nonumber
set norelativenumber
set laststatus=2
set history=1000
set undofile
set undoreload=10000
set cpoptions+=J
set list
set listchars=tab:›\ ,eol:¬,extends:❯,precedes:❮
set shell=/bin/bash
set lazyredraw
set matchtime=3
set showbreak=↪
set splitbelow
set splitright
set fillchars=diff:⣿
set ttimeout
set notimeout
set nottimeout
set autowrite
set shiftround
set autoread
set title
set number
set noeol   " don't add an automatic new line at the end of file.

" Tabs, spaces, wrapping {{{

set tabstop=2
set shiftwidth=2
set softtabstop=2
"set expandtab
set wrap
set textwidth=80
set formatoptions=qrn1
set colorcolumn=+1

" Backups 
set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup

" Color scheme 
set t_Co=256 
set background=dark
colorscheme ir_black

" Go related stuff.
set rtp+=$GOROOT/misc/vim
filetype plugin indent on
autocmd FileType go autocmd BufWritePre <buffer> Fmt
syntax on

" Make tabs spaces for these guys cause they're special.
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
autocmd Filetype erb setlocal ts=2 sw=2 expandtab
autocmd Filetype scss setlocal ts=2 sw=2 expandtab
autocmd Filetype vcl setlocal ts=2 sw=2 expandtab
