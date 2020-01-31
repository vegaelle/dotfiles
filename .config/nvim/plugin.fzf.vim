if (!exists("g:plugs['fzf.vim']"))
    finish
endif

" Jump to the existing window if possible
let g:fzf_buffers_jump = 1

command! -bang -nargs=* Ag
    \ call fzf#vim#ag(<q-args>,
    \                 <bang>0 ? fzf#vim#with_preview('up:60%')
    \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
    \                 <bang>0)

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Custom function example:
" command! -bang -nargs=? -complete=dir HFiles
" \ call fzf#vim#files(<q-args>, {'source': 'ag --hidden --ignore .git -g ""'}, <bang>0)

" Customize fzf colors to match your color scheme
let g:fzf_colors = {
            \ 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

let g:fzf_layout = { 'down': '~40%' }
let g:fzf_nvim_statusline = 0 " disable statusline overwriting

fun! s:fzf_root()
    let path = finddir(".git", expand("%:p:h").";")
    return fnamemodify(substitute(path, ".git", "", ""), ":p:h")
endfun

function! s:with_git_root()
    let root = systemlist('git rev-parse --show-toplevel')[0]
    return v:shell_error ? {} : {'dir': root}
endfunction
command! -nargs=* GAg
    \ call fzf#vim#ag(<q-args>, extend(s:with_git_root(), g:fzf_layout))
" Use rg (ripgrep, Faster!)
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, { 'options': '--bind=ctrl-e:select-all,ctrl-d:deselect-all' }, <bang>0)
command! -nargs=* GAg
    \ call fzf#vim#ag(<q-args>, extend(s:with_git_root(), g:fzf_layout))
function! s:with_itk_git_root()
    let root = systemlist('git -C '. g:ITKFolder . ' rev-parse --show-toplevel')[0]
    return v:shell_error ? {} : {'dir': root}
endfunction
command! -nargs=* IAg
    \ call fzf#vim#ag(<q-args>, extend(s:with_itk_git_root(), g:fzf_layout))
command! -nargs=* IFiles
    \ call fzf#vim#files(<q-args>, extend(s:with_itk_git_root(), g:fzf_layout))

command! -bang -nargs=* PAg
    \ call fzf#vim#ag(<q-args>,
    \                 <bang>0 ? fzf#vim#with_preview('up:60%')
    \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
    \                 <bang>0)


" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir PFiles
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

function! SearchWord()
    let grep_command = 'Rg'
    execute grep_command expand('<cword>')
endfunction

function! SearchWordVisualSelection() range
    let grep_command = 'Rg'
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    let old_clipboard = &clipboard
    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', old_reg, old_regtype)
    let &clipboard = old_clipboard
    execute grep_command selection
endfunction
