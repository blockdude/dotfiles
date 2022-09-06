" syntax highlighting
syntax on

" set tab spacing
set tabstop=3
set softtabstop=3
set shiftwidth=3

" show line numbers
set number

" scrolling and mouse
set ttymouse=sgr
set mouse=a

" disable backups
set noswapfile
set nobackup
set nowritebackup
set viminfo="NONE"

" quality of life
set linebreak
set nowrap
set smartindent
set autoindent
set incsearch

" indentation for filetypes
filetype plugin indent on

" insert delay
set timeoutlen=600
set ttimeoutlen=50

" disable auto comment
augroup auto_comment
	au!
	au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

" leader key
let mapleader="\<enter>"
