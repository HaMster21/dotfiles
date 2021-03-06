set nocompatible
syntax on
colorscheme desert
filetype indent plugin on

set laststatus=2
set number          " Show line numbers
set linebreak       " Break lines at word (requires Wrap lines)
set showbreak=->>   " Wrap-broken line prefix
set textwidth=100   " Line wrap (number of cols)
set lbr
set wrap
set showmatch       " Highlight matching brace
set visualbell      " Use visual bell (no beeping)
set scrolloff=5     " Keep lines above and below the cursor while scrolling
 
set hlsearch        " Highlight all search results
set smartcase       " Enable smart-case search
set ignorecase      " Always case-insensitive
set incsearch       " Searches for strings incrementally
 
set autoindent      " Auto-indent new lines
set expandtab       " Use spaces instead of tabs
set tabstop=4       " Make tabs 4 spaces wide
set softtabstop=4   " Number of spaces per Tab
set shiftwidth=4    " Number of auto-indent spaces
set smartindent     " Enable smart-indent
set smarttab        " Enable smart-tabs

set autoread        " Autoload changes to file from other views/programs

set ruler           " Show row and column ruler information

set undolevels=1000 " Number of undo levels
set backspace=indent,eol,start  " Backspace behaviour

"Highlight characters after column 100
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%101v.\+/ 

set listchars=tab:▸\ ,eol:¬
highlight NonText guifg=#191919
highlight SpecialKey guifg=#191919
" Show whitespace
set list 
