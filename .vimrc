" UTF-8 everywhere !
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

set shell=/bin/sh

"compatibilité vim / vi
set nocompatible

execute pathogen#infect()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" nombre d'espaces par tab
set tabstop=4

" nombre de caractère utilisé pour l'identation:
set shiftwidth=4

" test pour la synthax de python
let python_highlight_all = 1

set omnifunc=syntaxcomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete

" rend les recherches coloré avec un fond rouge
hi Search  term=reverse ctermbg=Red ctermfg=White guibg=Red guifg=White

" met en surbrillance les espaces et les tabs en trop
" highlight RedundantSpaces ctermbg=red guibg=red
" match RedundantSpaces /\s\+$\| \+\ze\t\|\t/

" numéro de lignes
set nu

set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set history=200    " keep 50 lines of command line history

" pas de case sensitive pour les recherches et recherche incremental
" set ignorecase
set noic

set list " pour afficher les machins affreux qui sont cacher (les tab et les endl)
set listchars=tab:\|·,trail:·,extends:$,nbsp:=  " pour rendre les trucs affiché par list un peu moins moche


" pour convertir les tab en espaces
set expandtab

" met en surbrillance tous les charactères dépassant la 80ème colonne
" au BufWinEnter *.py let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)


" Activation de la syntaxe
if has("syntax")
    syntax on
endif

" Afficher la barre d'état
set laststatus=2
" set statusline=%<%f\ %{fugitive#statusline()}\ %h%m%r%=%-14.(%l,%c%V%)\ %P
"set statusline=%F%m%r%h%w\ (%{&ff}){%Y}[%l,%v][%p%%]\ %{fugitive#statusline()}\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

"statusline setup
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


" Afficher les commandes incomplètes
set showcmd

" Affiche les délimiteurs () / <> / {} / []
set showmatch

" Afficher la position du curseur
set ruler


" Améliore l'affichage en disant à vim que nous utilisons un terminal rapide
set ttyfast

" Undo illimité depuis la création du fichier
if version >= 703
    set undofile
    set undodir=~/.vimtmp/undo
    silent !mkdir -p ~/.vimtmp/undo
endif


" Autocmd {{{1

set cindent
"set autoindent
"set smartindent

if has("autocmd")
    " Détection auto du format
    " + activer indent
    filetype plugin indent on
endif

" Convertir un html
map ,h :runtime syntax/2html.vim<cr>

" encoder rapidement
map ,c ggVGg?

" set background=dark

set background=dark "or light
highlight clear
if exists("syntax_on")
        syntax reset
    endif
    " let g:colors_name = "vivify"
    set t_Co=256

" let g:solarized_termcolors=256
colorscheme solarized

" highlight Boolean             guifg=#00ffff ctermfg=14                            gui=none cterm=none
" highlight CTagsClass          guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight CTagsGlobalConstant guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight CTagsGlobalVariable guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight CTagsImport         guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight CTagsMember         guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight Character           guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight Comment             guifg=#507080 ctermfg=74                            gui=none cterm=none
" highlight Conditional         guifg=#90ee90 ctermfg=114                           gui=none cterm=none
" highlight Constant            guifg=#00cdcd ctermfg=44                            gui=none cterm=none
" highlight Cursor              guifg=#ffffff ctermfg=15  guibg=#96cdcd ctermbg=152 gui=none cterm=none
" "highlight CursorColumn        guifg=#eeeeee ctermfg=255 guibg=#003853 ctermbg=24  gui=none cterm=none
" "highlight CursorLine          guifg=#eeeeee ctermfg=255 guibg=#003853 ctermbg=24  gui=none cterm=none
" highlight CursorColumn        guibg=none ctermbg=none gui=bold cterm=bold
" highlight CursorLine          guibg=#1C1C1C ctermbg=234  gui=none cterm=none
" highlight Debug               guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight Define              guifg=#bcd2ee ctermfg=153                           gui=none cterm=none
" highlight DefinedName         guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight Delimiter           guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight DiffAdd             guifg=#f8f8ff ctermfg=189 guibg=#008b8b ctermbg=30  gui=none cterm=none
" highlight DiffChange          guifg=#f8f8ff ctermfg=189 guibg=#008b00 ctermbg=28  gui=none cterm=none
" highlight DiffDelete          guifg=#f8f8ff ctermfg=189 guibg=#000000 ctermbg=0   gui=none cterm=none
" highlight DiffText            guifg=#00ffff ctermfg=14                            gui=none cterm=none
" highlight Directory           guifg=#20b2aa ctermfg=37                            gui=none cterm=none
" highlight EnumerationName     guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight EnumerationValue    guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight Error               guifg=#ffffe0 ctermfg=230 guibg=#b22222 ctermbg=124 gui=none cterm=none
" highlight ErrorMsg            guifg=#ffffe0 ctermfg=230 guibg=#b22222 ctermbg=124 gui=none cterm=none
" highlight Exception           guifg=#90ee90 ctermfg=114                           gui=none cterm=none
" highlight Float               guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight FoldColumn          guifg=#b0d0e0 ctermfg=117 guibg=#305060 ctermbg=74  gui=none cterm=none
" highlight Folded              guifg=#b0d0e0 ctermfg=117 guibg=#305060 ctermbg=74  gui=none cterm=none
" highlight Function            guifg=#9bcd9b ctermfg=151                           gui=none cterm=none
" highlight Identifier          guifg=#60cc60 ctermfg=77                            gui=none cterm=none
" highlight Ignore              guifg=#204050 ctermfg=74                            gui=none cterm=none
" highlight IncSearch           guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight Include             guifg=#a2b5cd ctermfg=110                           gui=none cterm=none
" highlight Keyword             guifg=#90ee90 ctermfg=114                           gui=none cterm=none
" highlight Label               guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight LineNr              guifg=#8db6cd ctermfg=74  guibg=#0f0f0f ctermbg=233 gui=none cterm=none
" highlight LocalVariable       guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight Macro               guifg=#8db6cd ctermfg=74                            gui=none cterm=none
" highlight MatchParen          guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight ModeMsg             guifg=#90ee90 ctermfg=114 guibg=#006400 ctermbg=22  gui=none cterm=none
" highlight MoreMsg             guifg=#2e8b57 ctermfg=72                            gui=none cterm=none
" " highlight NonText             guifg=#3d5d6d ctermfg=74  guibg=#1a1a1a ctermbg=234 gui=none cterm=none
" highlight NonText             guifg=#3d5d6d ctermfg=74                            gui=none cterm=none
" highlight Normal              guifg=#f8f8ff ctermfg=189 guibg=#000000             gui=none cterm=none
" highlight Number              guifg=#00ffff ctermfg=14                            gui=none cterm=none
" highlight Operator            guifg=#7fff00 ctermfg=118                           gui=none cterm=none
" highlight PMenu               guifg=#dddddd ctermfg=253 guibg=#747678 ctermbg=67  gui=none cterm=none
" highlight PMenuSbar           guifg=#dddddd ctermfg=253 guibg=#949698 ctermbg=67  gui=none cterm=none
" highlight PMenuSel            guifg=#88dd88 ctermfg=114 guibg=#a4a6a8 ctermbg=67  gui=none cterm=none
" highlight PMenuThumb          guifg=#dddddd ctermfg=253 guibg=#c4c6c8 ctermbg=110 gui=none cterm=none
" highlight PreCondit           guifg=#a4d3ee ctermfg=117                           gui=none cterm=none
" highlight PreProc             guifg=#87ceff ctermfg=117                           gui=none cterm=none
" highlight Question            guifg=#4eee94 ctermfg=85                            gui=none cterm=none
" highlight Repeat              guifg=#4eee94 ctermfg=85                            gui=none cterm=none
" highlight Search              guifg=#eeeeee ctermfg=255 guibg=#607b8b ctermbg=67  gui=none cterm=none
" highlight SignColumn          guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight Special             guifg=#66cdaa ctermfg=79                            gui=none cterm=none
" highlight SpecialChar         guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight SpecialComment      guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight SpecialKey          guifg=#324262 ctermfg=235  guibg=#091a23 ctermbg=0  gui=none cterm=none
" highlight SpellBad            guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight SpellCap            guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight SpellLocal          guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight SpellRare           guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight Statement           guifg=#90ee90 ctermfg=114                           gui=none cterm=none
" highlight StatusLine          guifg=#000000 ctermfg=0   guibg=#e0e0e0 ctermbg=254 gui=none cterm=none
" highlight StatusLineNC        guifg=#1a1a1a ctermfg=234 guibg=#999999 ctermbg=246 gui=none cterm=none
" highlight StorageClass        guifg=#add8e6 ctermfg=81                            gui=none cterm=none
" highlight String              guifg=#00e5ee ctermfg=14                            gui=none cterm=none
" highlight Structure           guifg=#add8e6 ctermfg=81                            gui=none cterm=none
" highlight TabLine             guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight TabLineFill         guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight TabLineSel          guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight Tag                 guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight Title               guifg=#e066ff ctermfg=171                           gui=none cterm=none
" highlight Todo                guifg=#00ffff ctermfg=14  guibg=#ff0000 ctermbg=124 gui=none cterm=none
" highlight Type                guifg=#add8e6 ctermfg=81                            gui=none cterm=none
" highlight Typedef             guifg=#add8e6 ctermfg=81                            gui=none cterm=none
" highlight Underlined          guifg=#838b83 ctermfg=65                            gui=underline cterm=underline
" highlight Union               guifg=#eeeeee ctermfg=255                           gui=none cterm=none
" highlight VertSplit           guifg=#000000 ctermfg=0   guibg=#999999 ctermbg=246 gui=none cterm=none
" highlight Visual              guifg=#2e8b57 ctermfg=72  guibg=#ffffff ctermbg=15  gui=none cterm=none
" highlight VisualNOS           guifg=#eeeeee ctermfg=255                           gui=underline cterm=underline
" highlight WarningMsg          guifg=#ff3030 ctermfg=203                           gui=none cterm=none
" highlight WildMenu            guifg=#000000 ctermfg=0   guibg=#7fff00 ctermbg=118 gui=none cterm=none
" highlight pythonBuiltin       guifg=#f8f8ff ctermfg=189                           gui=none cterm=none

autocmd insertEnter * set cursorline
autocmd insertLeave * set nocursorline
autocmd insertEnter * set cursorcolumn
autocmd insertLeave * set nocursorcolumn

" Enable filetype plugin
filetype plugin on
filetype indent on
filetype on

" }}}1

set mouse=a


" Tlist plugin
" let Tlist_Auto_Open = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let tlist_php_settings = 'php;f:function'
nnoremap <silent> <F8> :TlistToggle<CR>

" NERDTree plugin
nnoremap <silent> <F9> :NERDTreeToggle<CR>

set tw=80
set colorcolumn=81

au BufRead /tmp/mutt-* set tw=72

nnoremap <C-c> :let @/ = ""<CR>

" jcommenter plugin
let b:jcommenter_class_author='Damien Nicolas (damien@gordon.re)'
let b:jcommenter_file_author='Damien Nicolas (damien@gordon.re)'
source ~/.vim/macros/jcommenter.vim
nnoremap <F10> :call JCommentWriter()<CR>

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

" Hex mode
nnoremap <C-H> :Hexmode<CR>
inoremap <C-H> <Esc>:Hexmode<CR>
vnoremap <C-H> :<C-U>Hexmode<CR>

" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

" Flake8 plugin

autocmd BufWritePost *.py call Flake8()
let g:flake8_max_complexity=10

" vim-airline plugin

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" CtrlP plugin

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" tagbar plugin

nmap <F8> :TagbarToggle<CR>

source ~/.vimrc.bepo
