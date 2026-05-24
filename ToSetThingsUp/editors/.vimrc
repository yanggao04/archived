set number		  			" show line number
set cursorline				" highlight cursorline
set nocursorcolumn			" highlight cursorcolumn
set ruler                   

" undofile
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

syntax enable				" auto detect file type
syntax on		  			"
set expandtab				" auto convert tab to spaces
set tabstop=4				" tab width be 4
set shiftwidth=4			" auto indentation be 4
set autoindent				" inherit indentation of prev line
set laststatus=2			" command line 2 in height (show status bar)
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\                " set what is shown in status bar
let mapleader="`"			" shortcut prefix be '`'

set mouse=a					" allow mouse
set selection=exclusive		" 
set selectmode=mouse,key	" 
set matchtime=5				"
set showmode				" show mode beneath
set showcmd					" show command entered
set wildmenu				" allow tab to autofill command
set wildmode=longest,list,full
set ignorecase				" case insensitive when searching
set smartcase               " but be case seneitive when specified
set hlsearch				" highlighting search
set incsearch				" intime search match

autocmd BufWritePost $MYVIMRC source $MYVIMRC  " let vimrc auto reload when saved

""" Vim-Plug

call plug#begin()

" List your plugins here
" e.g. Plug 'tpope/vim-sensible'

" Enabling fzf vim-plug
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()
