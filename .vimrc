set nocompatible            " do not be vi when config loaded on command line
scriptencoding utf-8        " for the funky chars we will load

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" PLUGINS
Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'EinfachToll/DidYouMean'
Plugin 'henrik/vim-indexed-search'
Plugin 'mbbill/undotree'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-characterize'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-vinegar'
Plugin 'Valloric/MatchTagAlways'

call vundle#end()

" grab default glob matching
runtime macros/matchit.vim

" SETTINGS
syntax enable               " enable syntax processing
filetype plugin indent on   " load filetype-specific plugin and indent files
set encoding=utf-8          " this is the modern era
set background=dark         " dark backgroud for the eyes
set tabstop=4               " number of visual spaces per TAB
set softtabstop=4           " number of spaces in tab when editing
set shiftwidth=4            " when indenting with '>', use 4 spaces width
set expandtab               " tabs are spaces
set number                  " show line numbers
set relativenumber          " show other lines as relative from current
set cursorline              " highlight current line
set lazyredraw              " redraw only when we need to
set ignorecase              " case-insentive search by default
set smartcase               " search case-sensitive if there is an upper-case
set gdefault                " when replacing, use /g by default
set showmatch               " highlight matching [{()}]
set showcmd                 " show incomplete cmds down the bottom
set showmode                " show current mode down the bottom
set incsearch               " search as characters are entered
set hlsearch                " highlight matches
set foldenable              " enable folding
set foldlevelstart=10       " open most folds by default
set foldnestmax=10          " 10 nested fold max
set foldmethod=syntax       " syntax is used to specify folds
set mouse=a                 " full mouse support
set autoindent              " auto-indent after return
set autoread                " auto-reload file after changes
set autowrite               " automatically save before commands like :next and :make
set scrolloff=5             " always keep lines around the cursor
set sidescrolloff=7
set sidescroll=1
set virtualedit=block       " let cursor move past the last char in visual mode
set matchpairs+=<:>         " show more matching characters
set colorcolumn=+1          " mark the ideal max text width
set formatoptions-=o        " dont continue comments when pushing o/O
set wildmenu                " visual autocomplete for command menu
set wildmode=list:longest   " make cmdline tab completion similar to bash
set wildignore=*.o,*.obj,*~ " stuff to ignore when tab completing
set undofile                " persistent undo across sessions
set undodir=~/.vim/undo                 " dir must exist to work
set directory=~/.vim/swap//             " set common swap file dir
set clipboard=unnamed                   " all operations work with the clipboard
set backspace=indent,eol,start          " make backspace work over anything
set list listchars=trail:·,tab:»·       " render tabs and trailing spaces

let mapleader = ","         " leader key is comma

" PLUGIN CONFIG
" solarized
let g:solarized_termcolors=256  " for compatability with everything
colorscheme solarized

" undotree
nnoremap <F5> :UndotreeToggle<CR>

" matchtag
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'php' : 1,
    \}

" REMAPS
" for shift fumbles
nnoremap :Q! :q!
nnoremap :Q :q 
nnoremap :X :x
nnoremap :W :w

" use shift-space as escape (does not work because curses)
"inoremap <S-Space> <Esc>

" automatically exit insert mode wth up or down arrows
inoremap <silent> <Up> <ESC><Up>
inoremap <silent> <Down> <ESC><Down>

" space open/closes folds
nnoremap <Space> za

" when jumping to a given line, center the screen
nnoremap G Gzz

" switch higlight
nnoremap <leader><Space> :set hls!<CR>
" / highlights then enter search mode
nnoremap / :set hlsearch <CR>/
" clear search
nnoremap <leader>/ :let @/ = ""<CR>

" move by virtual lines when used without a count, and by physical lines when
" used with a count
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" stay in visual mode when indenting.
vnoremap < <gv
vnoremap > >gv

" make Y yank everything from the cursor to the end of the line
noremap Y y$
