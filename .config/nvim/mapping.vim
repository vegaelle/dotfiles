""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom mappings
" See bepotimist for homerow related mappings (tsrn)
"
" TODO: find a key and remap mkdx https://github.com/SidOfc/mkdx
"       candidate are È ù œ (if moving tab)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ----------------------------------------------------------------------------
" Neovim built-in
" ----------------------------------------------------------------------------
" Don't use Ex mode, use Q for formatting
noremap Q gq
" don't override register when pasting over
xnoremap p pgvy
" page up/down
noremap <BS> <PageUp>
noremap <Space> <PageDown>
" terminal escape instead of C-\ C-n
tnoremap <C-g> <C-\><C-n>

" ----------------------------------------------------------------------------
" Plugin pre-configuration for bepotimist
" It needs to be in the main configuration because of loading priorities
" ----------------------------------------------------------------------------
let g:surround_no_mappings = 1
let g:ranger_map_keys = 0
let g:bexec_no_mappings = 1
let g:bclose_no_plugin_maps = 1
let g:nvimgdb_disable_start_keymaps = 1

let g:user_emmet_leader_key='<C-y>'
let g:jedi#documentation_command = 'gh'   " vim Jedi needs to use the same key
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = '<leader>r'
let g:jedi#usages_command = '<leader>N'
let g:jedi#goto_assignments_command = '<leader>g'
let g:jedi#goto_command = '<leader>d'
let g:table_mode_map_prefix = ',\|'
let g:sneak#target_labels = "auiectsrnovdl"
" hack for sneak, to avoid remapping
nmap , <Nop>

" -----------------------------------------------------------------------------
" Plugins
" -----------------------------------------------------------------------------

" Completion (<tab>, <c-space>)
" -----------------------------------------------------------------------------

" Neosnippets
imap <C-space> <Plug>(neosnippet_expand_or_jump)
smap <C-space> <Plug>(neosnippet_expand_or_jump)
xmap <C-space> <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

"  Formatting
" -----------------------------------------------------------------------------

" Overwrite the default action for toggling quickfix
nnoremap <silent> màI :call mkdx#fzfQuickfixHeaders()<CR>

" Insert mode mapping for completion

" Rewrite some vim maps in insert mode, not that usefull anyway if you know 
" how to use vim in normal mode properly:
inoremap <C-j> <C-x><C-]>
inoremap <C-o> <C-x><C-o>

imap <c-k> <plug>(fzf-complete-word)
imap <c-l> <plug>(fzf-complete-line)
inoremap <expr> <c-f> fzf#vim#complete#path('ag --hidden -l -g ""')

" Global line completion (not just open buffers. ripgrep required.)
" TODO: add with ,l and ,L in normal mode
inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
            \ 'prefix': '^.*$',
            \ 'source': 'rg -n ^ --color always',
            \ 'options': '--ansi --delimiter : --nth 3..',
            \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))


" Executing
" -----------------------------------------------------------------------------

nmap <leader>p <Nop>
nmap <leader>s <Nop>
" ALE
nmap <leader>af <Plug>(ale_fix)
nmap <leader>ad <Plug>(ale_detail)
" Bexec
vmap <leader>x :call bexec#Visual()<CR>
nmap <leader>x :call bexec#Normal()<CR>
nmap <leader>l :call bexec#Live()<CR>
nmap <leader>pi :PlugInstall<CR>
nmap <leader>pu :PlugUpdate<CR>
nmap <leader>pU :PlugUpgrade<CR>
nmap <leader>pc :PlugClean<CR>
nmap <leader>ps :PlugStatus<CR>
nmap <leader>pd :PlugDiff<CR>
nmap <leader>pI :w<CR>:source ~/.config/nvim/init.vim<CR>:PlugInstall<CR>
nmap <leader>m :make<CR>
nmap <leader>tt :!tox<CR>
nmap <leader>tp :!pytest<CR>
" Order all css properties
nnoremap <leader>c :<C-u>g/{/ .+1,/}/-1 sort<CR>

command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
            \ | wincmd p | diffthis
nnoremap <leader>do :DiffOrig<CR>
" Clean dirty white space (EOL)
nnoremap <leader><space> :silent! %s/\s\+$//<CR>

" Forgotten unbreakable spaces… for French only
" TODO: operator cleaner?
nnoremap <leader>  :%s/\(\S\) \([:;?!]\)/\1 \2/g<CR>


" Denite
"   ;         - Browser currently open buffers
"   <leader>t - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and
"   close window if no results
"   <leader>j - Search current directory for occurences of word under cursor
nmap ; :Denite buffer -split=floating -winrow=1<CR>
nmap <leader>t :Denite file/rec -split=floating -winrow=1<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty -mode=normal<CR>
nnoremap <leader>j :<C-u>DeniteCursorWord grep:. -mode=normal<CR>

if (exists("g:plugs['denite.nvim']"))
    call denite#custom#map(
          \ 'insert',
          \ '<C-n>',
          \ '<denite:move_to_next_line>',
          \ 'noremap'
          \)

    call denite#custom#map(
          \ 'insert',
          \ '<C-t>',
          \ '<denite:move_to_previous_line>',
          \ 'noremap'
          \)

    call denite#custom#map(
          \ 'insert',
          \ '<C-j>',
          \ '<denite:do_action:tabopen>',
          \ 'noremap'
          \)

    call denite#custom#map(
          \ 'insert',
          \ '<C-space>',
          \ '<denite:toggle_select>',
          \ 'noremap'
          \)

    call denite#custom#map(
          \ 'insert',
          \ '<C-g>',
          \ '<denite:enter_mode:normal>',
          \ 'noremap'
          \)

    call denite#custom#map(
          \ 'insert',
          \ '<C-r>',
          \ '<denite:jump_to_previous_source>',
          \ 'noremap'
          \)

    call denite#custom#map(
          \ 'insert',
          \ '<C-s>',
          \ '<denite:jump_to_next_source>',
          \ 'noremap'
          \)

    call denite#custom#map(
          \ 'insert',
          \ '<C-h>',
          \ '<denite:restore_sources>',
          \ 'noremap'
          \)
endif

" Denite-like mappings
nmap <leader>s :w<CR>
nmap <leader>S :w!<CR>
nmap <leader>w :s
nmap <leader>W :s!
nmap <leader>q :q<CR>
nmap <leader>Q :q!<CR>
nmap <leader>x :x<CR>
nmap <leader>X :x!<CR>
nmap <leader>d :bdelete<CR>
nmap <leader>D :bdelete!<CR>

" -----------------------------------------------------------------------------
" Memo:
" -----------------------------------------------------------------------------
" .         hidden hiles are included
" c         current file directory
" h         home directory
" lower     files
" upper     directories
" -----------------------------------------------------------------------------

" Recent and favorites
nnoremap <Tab> :<C-u>Denite buffer<CR>
nnoremap <leader>, :<C-u>Denite -resume<CR>
nnoremap <leader>m :<C-u>Denite dirmark<CR>
nnoremap <leader>M :<C-u>Denite dirmark/add<CR>
nnoremap <leader><space> :<C-u>Denite -source-names=hide file_mru directory_mru dirmark<CR>

" [R]ecent
nnoremap <leader>r :<C-u>Denite file_mru<CR>
nnoremap <leader>R :<C-u>Denite directory_mru<CR>

" [f]ile
nnoremap <leader>f :<C-u>DeniteProjectDir file/rec<CR>
nnoremap <leader>.f :<C-u>DeniteProjectDir file/rec/hidden<CR>
nnoremap <leader>cf :<C-u>DeniteBufferDir file/rec<CR>
nnoremap <leader>.cf :<C-u>DeniteBufferDir file/rec/hidden<CR>
nnoremap <leader>hf :<C-u>Denite -path=~ file/rec<CR>
nnoremap <leader>.hf :<C-u>Denite -path=~ file/rec/hidden<CR>

" [F]older
nnoremap <leader>F :<C-u>DeniteProjectDir directory_rec<CR>
nnoremap <leader>.F :<C-u>DeniteProjectDir directory/rec/hidden<CR>
nnoremap <leader>cF :<C-u>DeniteBufferDir directory_rec<CR>
nnoremap <leader>.cF :<C-u>DeniteBufferDir directory/rec/hidden<CR>
nnoremap <leader>hF :<C-u>Denite -path=~ directory_rec<CR>
nnoremap <leader>.hF :<C-u>Denite -path=~ directory/rec/hidden<CR>

" [b]rowse (file/directory non recursive)
nnoremap <leader>b :<C-u>DeniteProjectDir file<CR>
nnoremap <leader>cb :<C-u>DeniteBufferDir file<CR>
nnoremap <leader>hb :<C-u>Denite -path=~ file<CR>

" [G]it
" TODO: bare repo config?
nnoremap <leader>g :<C-u>DeniteProjectDir
    \ `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'`<CR>
" nnoremap <leader>G :<C-u>DeniteProjectDir
"     \ `finddir('.git', ';') != '' ? 'directory/rec/git' : 'directory/rec'`<CR>
nnoremap <leader>cg :<C-u>DeniteBufferDir
    \ `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'`<CR>
" nnoremap <leader>cG :<C-u>DeniteBufferDir
"     \ `finddir('.git', ';') != '' ? 'directory/rec/git' : 'directory/rec'`<CR>

" Searching
nnoremap <leader># :<C-u>DeniteCursorWord grep:. -mode=normal<CR>
nnoremap <leader>/ :<C-u>DeniteProjectDir grep:. -mode=normal<CR>
map <leader>a :DeniteProjectDir -buffer-name=grep -default-action=quickfix grep:::!<CR>
map <leader>ca :DeniteBufferDir -buffer-name=grep -default-action=quickfix grep:::!<CR>
map <leader>ha :Denite -path=~ -buffer-name=grep -default-action=quickfix grep:::!<CR>

" Ranger
nnoremap ,e :RangerWorkingDirectory<CR>
nnoremap ,ce :RangerCurrentFile<CR>
nnoremap ,he :Ranger ~<CR>

" Others
nnoremap <leader>à :<C-u>Denite jump<CR>
nnoremap <leader>C :<C-u>Denite colorscheme<CR>
nnoremap <leader>E :<C-u>Denite emoji<CR>
nnoremap <leader>k :<C-u>Denite help<CR>
nnoremap <leader>l :<C-u>Denite line<CR>
" nnoremap <leader>n :<C-u>Defx<CR>
nnoremap <leader>t :<C-u>Denite tag<CR>
" nnoremap <leader>u :<C-u>:Gundo<CR>
nnoremap <leader>y :<C-u>Denite register<CR>
nnoremap <leader>Z :<C-u>Denite grammarous<CR>
nnoremap <leader>z :<C-u>Denite spell<CR>
nnoremap <leader>: :<C-u>Denite command<CR>
nnoremap <leader>… :<C-u>Denite command_history<CR>
nnoremap <leader>! :Denite output:!
nnoremap <leader>? :map <leader><CR>

" markdown
nmap [om <Plug>MarkdownPreview
nmap ]om <Plug>MarkdownPreviewStop
nmap yom <Plug>MarkdownPreviewToggle

" Plugin ALE {{{
nnoremap <silent> ]oa :ALEDisable<cr>
nnoremap <silent> [oa :ALEEnable<cr>
nnoremap <silent> yoa :ALEToggle<cr>
nnoremap <silent> ylf :ALEFix<cr>
nnoremap <silent> yld :ALEDetail<cr>
nnoremap <silent> [h :ALEPrevious<cr>
nnoremap <silent> ]h :ALENext<cr>

" defx
nnoremap <leader>n :Defx -split=vertical -winwidth=35 -direction=topleft -columns=git:indent:icons:filename:type -toggle -search=`expand('%:p')` `getcwd()`<CR>

" fzf
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <C-x><C-j> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

nnoremap <silent> <C-p> :exe 'Files ' . <SID>fzf_root()<CR>
nnoremap <silent> <C-s> :Rg<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>bB :Windows<CR>
nnoremap <silent> <Leader>; :Commands<CR>
nnoremap <silent> <Leader>fhl :Helptags<CR>
nnoremap <silent> <Leader>fl :BLines<CR>
nnoremap <silent> <Leader>fL :Lines<CR>
nnoremap <silent> <Leader>w :call SearchWord()<CR>
vnoremap <silent> K :call SearchWordVisualSelection()<CR>
nnoremap <silent> <Leader>ft :BTags<CR>
nnoremap <silent> <Leader>fT :Tags<CR>
nnoremap <silent> <Leader>gl :Commits<CR>
nnoremap <silent> <Leader>ga :BCommits<CR>
" History Search
nnoremap <silent> <Leader>gs :History/<CR>
" History Commands
nnoremap <silent> <Leader>gc :History:<CR>
" History Files
nnoremap <silent> <Leader>gf :History:<CR>

" Misc.
" -----------------------------------------------------------------------------
nnoremap <C-c> :let @/ = ""<CR>

" vim-bookmarks
nnoremap ms <Plug>BookmarkShowAll
