execute pathogen#infect()
syntax enable               " enable syntax processing
set background=dark         " dark backgroud for the eyes
let g:solarized_termcolors=256  " for compatability with everything
colorscheme solarized
set nocompatible            " do not be vi when config loaded on command line
set tabstop=4               " number of visual spaces per TAB
set softtabstop=4           " number of spaces in tab when editing
set shiftwidth=4            " when indenting with '>', use 4 spaces width
set expandtab               " tabs are spaces
set number                  " show line numbers
set relativenumber          " show other lines as relative from current
set cursorline              " highlight current line
filetype plugin indent on   " load filetype-specific indent files
set wildmenu                " visual autocomplete for command menu
set lazyredraw              " redraw only when we need to
set ignorecase              " case-insentive search by default
set smartcase               " search case-sensitive if there is an upper-case
set gdefault                " when replacing, use /g by default
set showmatch               " highlight matching [{()}]
set incsearch               " search as characters are entered
set hlsearch                " highlight matches
set foldenable              " enable folding
set foldlevelstart=10       " open most folds by default
set foldnestmax=10          " 10 nested fold max
set foldmethod=syntax       " syntax is used to specify folds
set mouse=a                 " full mouse support
set autoindent              " auto-indent after return
set autoread
set scrolloff=5             " always keep lines around the cursor
set virtualedit=block       " let cursor move past the last char in visual mode
set matchpairs+=<:>         " show more matching characters
set undofile                " persistent undo across sessions
set undodir=~/.vim/undodir  " dir must exist to work
set clipboard=unnamed       " all operations work with the clipboard
set backspace=indent,eol,start  " make backspace work over anything
set list listchars=trail:·,tab:»·   " render tabs and trailing spaces

let mapleader = ","         " leader key is comma

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
