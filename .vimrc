set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

set nocompatible

set backspace=indent,eol,start

set tabstop=4

set shiftwidth=4

hi Search term=reverse ctermbg=Red ctermfg=White guibg=Red guifg=White

set nu
set ruler
set showcmd
set incsearch
set history=200
if version >= 703
    set undofile
    set undodir=~/.vimtmp/undo
    silent !mkdir -p ~/.vimtmp/undo
endif

set noic

set list
set listchars=tab:\|·,trail:·,extends:$,nbsp:·

set expandtab

if has("syntax")
    syntax on
endif

set laststatus=2
set showmatch
set ttyfast

if !isdirectory($HOME . '/.vim/bundle/Vundle.vim')
    echohl "Vundle not found, running without plugin"
    let s:plugin_off = 1
else
    filetype off
    " set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    " Themes
    " Plugin 'endel/vim-github-colorscheme'
    Plugin 'altercation/vim-colors-solarized'
    " Plugin 'morhetz/gruvbox'

    " dependencies
    " Plugin 'tomtom/tlib_vim'                " utility functions
    " Plugin 'tobyS/vmustache'                " vim templates (for phpDoc)
    " Plugin 'MarcWeber/vim-addon-mw-utils'   " ?

    " Favorites
    " Plugin 'Shougo/unite.vim'
    " Plugin 'Shougo/vimproc.vim'             " Unite deps for file_sync
    " Plugin 'Shougo/neomru.vim'              " Unite deps for file_mru
    Plugin 'kien/ctrlp.vim'                 " Control-P menu
    Plugin 'scrooloose/nerdtree'

    " Plugin 'airblade/vim-gitgutter'         " Git gutter on the left
    Plugin 'bling/vim-airline'              " Cool status bar

    Plugin 'tpope/vim-fugitive'             " Git integration
    " Plugin 'tpope/vim-surround'             " motions around words
    " Plugin 'tpope/vim-repeat'               " missing repeat with dot
    Plugin 'tpope/vim-speeddating'          " inc/dec dates and numbers

    " Plugin 'marijnh/tern_for_vim'           " ctags for javascript
    " FIXME: bepo shortcuts
    Plugin 'tpope/vim-commentary'           " quick comment
    Plugin 'majutsushi/tagbar'

    Plugin 'sjl/gundo.vim'                  " save undo when closing file
    Plugin 'scrooloose/syntastic'           " syntax checking
    Plugin 'mattn/emmet-vim'
    Plugin 'godlygeek/tabular'              " must be BEFORE markdown plugin
    "Plugin 'sirver/ultisnips'
    Plugin 'honza/vim-snippets'
    " Plugin 'sheoak/vim-mucfind'             " quickly insert mu result
    " Plugin 'joonty/vdebug'                  " multi-language debugger
    " Plugin 'jaredly/vim-debug'

    " Filetype specific plugins
    Plugin 'PotatoesMaster/i3-vim-syntax'            " i3 config syntax
    " Plugin 'digitaltoad/vim-jade'                    " jade syntax
    Plugin 'plasticboy/vim-markdown'                 " markdown
    Plugin 'hail2u/vim-css3-syntax'                  " CSS3 syntax
    Plugin 'othree/javascript-libraries-syntax.vim'  " Javascript
    " Plugin 'tobyS/pdv'                               " phpDocumentor
    Plugin 'jelera/vim-javascript-syntax'
    Plugin 'burnettk/vim-angular'
    Plugin 'elzr/vim-json'                           " JSON
    " Plugin 'tpope/vim-jdaddy' " json manipulation
    Plugin 'vim-pandoc/vim-pandoc'                   " pandoc
    Plugin 'vim-pandoc/vim-pandoc-syntax'
    Plugin 'nvie/vim-flake8'
    Plugin 'peterhoeg/vim-qml'

    "Plugin 'vim-scripts/JavaScript-Indent'
    "Plugin 'pangloss/vim-javascript'
    "Plugin 'cakebaker/scss-syntax.vim'             " SASS. Broken for .sass?
    Plugin 'aperezdc/vim-template'
    "Plugin 'Valloric/YouCompleteMe'

    " Use local bundles config if available
    if filereadable(expand("~/.vimrc.bundles.local"))
        source ~/.vimrc.bundles.local
    endif

    " All of your Plugins must be added before the following line
    call vundle#end()            " required
endif


"line setup
set statusline =%#identifier#
set statusline+=[%t] "tail of the filename
set statusline+=%*

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h "help file flag
set statusline+=%y "filetype

"read only flag
set statusline+=%#identifier#
set statusline+=%r
set statusline+=%*

"modified flag
set statusline+=%#identifier#
set statusline+=%m
set statusline+=%*

set statusline+=%{fugitive#statusline()}

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}

set statusline+=%{StatuslineLongLineWarning()}

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%= "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c, "cursor column
set statusline+=%l/%L "cursor line/total lines
set statusline+=\ %P "percent through file

set cindent

if has("autocmd")
    " Détection auto du format
    " + activer indent
    filetype plugin indent on
endif

set background=dark "or light
highlight clear
if exists("syntax_on")
    syntax reset
endif
" let g:colors_name = "vivify"
set t_Co=256
" set t_Co=88

colorscheme solarized

autocmd insertEnter * set cursorline
autocmd insertLeave * set nocursorline
autocmd insertEnter * set cursorcolumn
autocmd insertLeave * set nocursorcolumn

filetype plugin on
filetype indent on
filetype on

set mouse=a

set tw=79
set colorcolumn=80

set foldmethod=indent

au BufRead /tmp/mutt-* set tw=72

nnoremap <C-c> :let @/ = ""<CR>

" Remappings
" Remapping de la complétion sur Ctrl + Espace
imap <C-Space> <C-X><C-O>
" Navigation entre les fenêtres avec Espace puis flèches directionelles
" (après avoir séparé la fenêtre en deux avec :sp ou :vs, on passe d'une fenêtre à une
" autre en appuyant sur Espace puis une flèche directionnelle, bien plus pratique que
" de faire Ctrl + W puis une flèche
map <silent> <SPACE><up> <W-w><up>
map <silent> <SPACE><down> <W-w><down>
map <silent> <SPACE><right> <W-w><right>
map <silent> <SPACE><left> <W-w><left>
" / Remappings

nnoremap <silent> <F9> :NERDTreeToggle<CR>


autocmd BufWritePost *.py call Flake8()

" Spell mappings {{{
" If you are using bépo, see vimrc.bepo
"
" FIXME: this mix non-spell command
" -----------------------------------------------------------------------------
if has("spell")

    command! English setlocal spell! spelllang=en
    command! French  setlocal spell! spelllang=fr
    command! Nospell setlocal nospell

    augroup spell

        au!

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text  setlocal
            \ tw=79
            \ spell spelllang=fr

        autocmd FileType markdown setlocal
            \ tw=79
            \ formatoptions-=t
            \ spell spelllang=fr

        " git commit messages
        autocmd FileType gitcommit setlocal
            \ tw=50
            \ colorcolumn=72
            \ spell spelllang=en

        " Mail: remove annoying trail space detection and set gutter
        autocmd FileType mail
            \ setlocal tw=72
            \ spell spelllang=fr
            \ listchars=tab:\ \

    augroup END
end
" }}}

" }}}


let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

let g:vim_markdown_folding_disabled = 1


let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

nmap <F8> :TagbarToggle<CR>

source ~/.vimrc.bepo
