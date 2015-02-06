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
Bundle 'fatih/vim-go'


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

filetype plugin indent on
filetype indent on
syntax on

" Show trailing whitespaces
match ErrorMsg '\s\+$'
function! TrimWhiteSpace()
	%s/\s\+$//e
endfunction
" Automatically trim trailing whitespace on these files
autocmd FileType c,h,ruby,erb,python autocmd BufWritePre <buffer> :call TrimWhiteSpace()

" Make tabs spaces for these guys cause they're special.
autocmd Filetype html,ruby,erb,scss,vcl,haml,c,h setlocal ts=2 sw=2 expandtab
autocmd Filetype haml,python setlocal ts=2 sw=2 noexpandtab

" Restore cursor position, window position, and last search after running a
" command.
function! Preserve(command)
  " Save the last search.
  let search = @/

  " Save the current cursor position.
  let cursor_position = getpos('.')

  " Save the current window position.
  normal! H
  let window_position = getpos('.')
  call setpos('.', cursor_position)

  " Execute the command.
  execute a:command

  " Restore the last search.
  let @/ = search

  " Restore the previous window position.
  call setpos('.', window_position)
  normal! zt

  " Restore the previous cursor position.
  call setpos('.', cursor_position)
endfunction

" Re-indent the whole buffer.
function! Indent()
  call Preserve('normal gg=G')
endfunction

" Autoindent these guys upon save.
autocmd FileType ruby,erb,python,scss autocmd BufWritePre <buffer> :call Indent()
