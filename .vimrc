syntax on

" Set tab spacing
set tabstop=3
set softtabstop=3
set shiftwidth=3
set expandtab

" Comment line break limit
set textwidth=60

" Show Line Numbers
set number

" Fixes scrolling issue for st and/or archlinux
set ttymouse=sgr
set mouse=a

" Stops words from breaking when reaching the end of the screen
set linebreak

" Stops vim from making backup files
set noswapfile
set nobackup
set nowritebackup

" disable .viminfo
set viminfo="NONE"

set smartindent
set autoindent
set nowrap
set incsearch

filetype plugin indent on

" fixes visual block insert delay
set timeoutlen=600
set ttimeoutlen=0

" plug plugin manager
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'puremourning/vimspector'
Plug 'bfrg/vim-cpp-modern'
Plug 'szw/vim-maximizer'
Plug 'preservim/nerdtree'
Plug 'vim-scripts/bash-support.vim'

call plug#end()

" Disable auto commenting
augroup auto_comment
	au!
	au FileType * setlocal formatoptions-=rco
	au FileType c setlocal comments=sl:/*,mb:\ *,elx:\ */ formatoptions+=rco
	au FileType h setlocal comments=sl:/*,mb:\ *,elx:\ */ formatoptions+=rco
augroup END


" Set colorsheme
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
set background=dark

" Shortcuts
let mapleader="\<enter>"

" Turn off or on paste mode to properly paste blocks of code or indented text
nnoremap <leader>h :set invpaste paste?<CR>
nnoremap <leader>s :w <bar> source ~/.vimrc<CR>

nnoremap <leader>m :MaximizerToggle<CR>
nnoremap <leader>n :NERDTreeToggle<CR>

" Vimspector
let g:vimspector_enable_mappings='HUMAN'
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dq :VimspectorReset<CR>
nnoremap <leader>dn :call vimspector#ClearBreakpoints()<CR>

nmap <leader>dc <Plug>VimspectorContinue
nmap <leader>dr <Plug>VimspectorRestart
nmap <leader>ds <Plug>VimspectorStop
nmap <leader>d<space> <Plug>VimspectorPause
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dh <Plug>VimspectorStepInto
nmap <leader>do <Plug>VimspectorStepOut
nmap <leader>dt <Plug>VimspectorRunToCursor
nmap <leader>db <Plug>VimspectorToggleBreakpoint

" Sets leader to compile and run programs based on the file extention
if filereadable("./Makefile")
	nnoremap <leader>c :make!<CR>
else
	autocmd filetype python nnoremap <leader>c :w <bar> exec '!python '.shellescape('%')<CR>
	autocmd filetype c nnoremap <leader>c :w <bar> exec '!gcc -g '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
	autocmd filetype cpp nnoremap <leader>c :w <bar> exec '!g++ '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
	autocmd filetype java nnoremap <leader>c :w <bar> exec '!javac -d out '.shellescape('%').' && java -cp out '.shellescape('%:r')<CR>
endif
