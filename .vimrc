syntax on
filetype plugin indent on

" Set tab spacing
set tabstop=4
set softtabstop=4
set shiftwidth=4
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

set encoding=utf-8
set fenc=utf-8

set tabpagemax=100

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
Plug 'rust-lang/rust.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" Set corrent filetypes for c files
augroup project
    au!
    au BufRead,BufNewFile *.h,*.c set filetype=c
augroup END

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

"fzf
nnoremap <leader>f :Files<CR>
