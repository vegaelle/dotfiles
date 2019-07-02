""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic settings for vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -----------------------------------------------------------------------------
" Basic vim settings
" -----------------------------------------------------------------------------

set hidden                     " no alert if current buffer has not been saved
set modeline                   " enable modelines comments
set modelines=1                " maximum number for modelines
set tags=.ctags                " search for tags file where vim is open
set fileformat=unix            " unix format by default, of course
set visualbell                 " no sounds
set noerrorbells
set shell=zsh                  " shell zsh by default

" -----------------------------------------------------------------------------
" History / undo
" -----------------------------------------------------------------------------

set history=500                 " keep 500 lines of command line history
set backup                      " make a backup before overwritting
set swapfile                    " use a swapfile by default
set writebackup                 " backup before overwritting a file
set sessionoptions-=options     " do not save options

" Persistent Undo
" Keep undo history across sessions, by storing in file.
if has('persistent_undo')
    set undofile
endif

" -----------------------------------------------------------------------------
" Editing
" -----------------------------------------------------------------------------
set complete-=i                      " scan current and included files
set ttimeout
set ttimeoutlen=100                  " time waited before end of sequence
set autoread                         " detect file changed outside of vim
set tabstop=4                        " number of visual spaces per TAB
set softtabstop=4                    " number of spaces in tab when editing
set shiftwidth=4
set expandtab                        " tabs are spaces
set listchars=nbsp:·,trail:¤,tab:\ \ " show invisible nbsp/tabs spaces
set list
set backspace=indent,eol,start       " allow all backspacing in insert mode
set showmatch                        " briefly jump to matching bracket
set nojoinspaces                     " only one space when joining lines
set nrformats-=octal                 " numbers with leading zeros are not octal
set diffopt+=vertical                " start diff mode with vert. splits

 " yank to the system clipboard by default
if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
elseif has('clipboard')
    set clipboard=unnamed
endif

" do not use insert comment on new line with o command
set formatoptions=crqln

if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j        " delete comment char on second line when
                                " joining two commented lines
endif

" -----------------------------------------------------------------------------
" Searching
" -----------------------------------------------------------------------------
set incsearch           " search as characters are entered
set hlsearch          " highlight matches off
set ignorecase
set smartcase
"set gdefault            " Add the g flag to search/replace by default

" -----------------------------------------------------------------------------
" Folding
" -----------------------------------------------------------------------------
set nofoldenable        " enable folding
set foldlevelstart=50   " open most folds by default
set foldnestmax=2       " 2 nested fold max
set foldmethod=manual   " manual folding only
set foldopen+=search    " open fold when searching

" -----------------------------------------------------------------------------
" UI
" -----------------------------------------------------------------------------
set number            " show line number ?
set norelativenumber    " show relative number also ?
set cursorline          " highlight current line
set colorcolumn=80
set tw=79
set showcmd             " display incomplete commands
set showmode            " already in airline?
set lazyredraw          " redraw only when we need to
set ttyfast             " indicates a fast terminal connection, faster redraw
set showmatch           " highlight matching 
set ruler               " show the cursor position all the time
set scrolloff=6         " nb of screen lines to keep above and below the cursor.
set sidescrolloff=5
set guioptions=a
set mouse=a             " enable mouse support
set helpheight=100      " Set window height when opening Vim help windows
set confirm             " Ask to save buffer instead of failing
set nowrap              " Don't wrap lines
set linebreak           " Wrap lines at convenient points
set display+=lastline   " Show as much as possible of long line (no @)
set previewheight=20    " preview window height
set termguicolors
set splitbelow          " new vertical splits are open below
set splitright          " new horizontal splits are open on the right
set wildignore+=*.o,*.obj,.git,*.jpg,*.png,*.gif,*.pdf,*.doc,*.swp,*.swf,*.bak
set wildignore+=*.zip,*.tar,*.gz,*.ico,*.ttf,*.eot,*/tmp/*,*/node_modules/*
set wildignore+=*.exe,*.mov,*.msi,*.xls,.ctags,*vim/backups*,*sass_cache*
set wildignore+=*.woff,*.woff2,*.ttf,*.eot
set wildignore+=*DS_Store*
set wildmenu            " Better command-line completion

set nolazyredraw

" Add guard around 'wildignorecase' to prevent terminal vim error
if exists('&wildignorecase')
    set wildignorecase
endif

if has("syntax")
    syntax on
endif

