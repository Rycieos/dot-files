set nocompatible            " do not be vi when config loaded on command line
scriptencoding utf-8        " for the funky chars we will load

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" PLUGINS
Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'EinfachToll/DidYouMean'
Plugin 'ervandew/supertab'
Plugin 'henrik/vim-indexed-search'
Plugin 'kopischke/vim-stay'
Plugin 'mbbill/undotree'
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
" http://vimdoc.sourceforge.net/htmldoc/options.html
syntax enable               " enable syntax processing
filetype plugin indent on   " load filetype-specific plugin and indent files
set autoindent              " auto-indent after return
set autoread                " auto-reload file after changes
set autowrite               " automatically save on buffer closing commands
set background=dark         " dark background for the eyes
set backspace=2             " make backspace work over anything
set clipboard=unnamed       " all operations work with the clipboard
set colorcolumn=+1          " mark the ideal max text width
set cursorline              " highlight current line
set directory=~/.vim/swap// " set common swap file dir
set display=lastline        " as much as possible of the last line will be shown
set encoding=utf-8          " this is the modern era
set expandtab               " tabs are spaces
set foldenable              " enable folding
set foldlevelstart=10       " open most folds by default
set foldmethod=syntax       " syntax is used to specify folds
set foldnestmax=10          " 10 nested fold max
set formatoptions-=o        " don't continue comments when pushing o/O
set gdefault                " when replacing, use /g by default
set hidden                  " make a buffer hidden when editing another one
set hlsearch                " highlight matches
set ignorecase              " case-insensitive search by default
set incsearch               " search as characters are entered
set lazyredraw              " redraw only when we need to
set lcs=tab:»·,trail:·      " render tabs and trailing spaces
set list                    " render special chars
set matchpairs+=<:>         " show more matching characters
set mouse=a                 " full mouse support
set number                  " show line numbers
set pastetoggle=<F11>       " allow for paste mode toggle
set relativenumber          " show other lines as relative from current
set ruler                   " show the cursor position all the time
set scrolloff=5             " always keep lines around the cursor vertically
set shiftwidth=4            " when indenting with '>', use 4 spaces width
set showcmd                 " show incomplete commands down the bottom
set showmatch               " highlight matching [{()}]
set showmode                " show current mode down the bottom
set sidescrolloff=7         " always keep lines around the cursor horizontally
set sidescroll=1            " how quickly to move the screen sideways
set smartcase               " search case-sensitive if there is an upper-case
set smartindent             " do smart autoindenting when starting a new line
set softtabstop=4           " number of spaces in tab when editing
set spelllang=en_us         " language for spell check
set tabstop=4               " number of visual spaces per TAB
set undofile                " persistent undo across sessions
set undodir=~/.vim/undo     " dir must exist to work
set vi+=n~/.vim/viminfo     " put the viminfo file not in home dir
set vop=cursor,folds,slash,unix     " save meta data with :mkview
set virtualedit=block       " let cursor move past the last char in visual mode
set wildignore=*.o,*.obj,*~ " stuff to ignore when tab completing
set wildmenu                " visual auto complete for command menu
set wildmode=list:longest   " make command line tab completion similar to bash

if has("mouse_sgr")         " fixes not being able to click on parts of screen
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

let mapleader = ","         " leader key is comma

" PLUGIN CONFIG
" solarized
let g:solarized_termcolors=256  " for compatibility with everything
colorscheme solarized

" undotree
nnoremap <silent> <F3> :UndotreeToggle<CR>

" matchtag
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'php' : 1,
    \}

" supertab | I get their point, but down makes more sense
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" spell check
function Spell()
    if &spell
        setlocal nospell
        echo "Spell checking off"
    else
        setlocal spell
        echo "Spell checking on"
    endif
endfunction

" for when we need to edit a file with tabs
function Tabs ()
    if &expandtab
        setlocal listchars=tab:\ \ ,trail:·
        setlocal noexpandtab
        echo "Tabs"
    else
        setlocal listchars=tab:»·,trail:·
        setlocal expandtab
        echo "Spaces"
    endif
endfunction

" REMAPS
" exit
nnoremap <silent> <F4> :quit<CR>

" reload
nnoremap <silent> <F5> :edit<CR>

" command
nnoremap <F6> :

" spell check
nnoremap <silent> <F7> :call Spell()<CR>

" toggle tabs
nnoremap <silent> <F8> :call Tabs()<CR>

" remove all trailing whitespace by pressing F9
nnoremap <silent> <F9> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>:echo "Trimmed trailing whitespace"<CR>

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

" clear search
nnoremap <silent> <leader>/ :let @/ = ""<CR>

" move by virtual lines when used without a count, and by physical lines when
" used with a count
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
noremap <silent> <expr> <DOWN> (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> <UP> (v:count == 0 ? 'gk' : 'k')

" stay in visual mode when indenting.
vnoremap < <gv
vnoremap > >gv

" make Y yank everything from the cursor to the end of the line
noremap Y y$
