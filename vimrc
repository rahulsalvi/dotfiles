" General Settings
" ----------------
set backspace=indent,eol,start
set clipboard=unnamedplus
set expandtab
set hlsearch
set incsearch
set lazyredraw
set mouse=a
set number
set relativenumber
set selection=exclusive
set shiftwidth=4
set showcmd
set sidescroll=1
set softtabstop=4
set splitbelow
set splitright
set tabstop=4
set updatetime=300
set virtualedit=all
set wildmenu

set nobackup
set nocompatible
set nomodeline
set noshowmode
set noswapfile
set nowrap
set nowritebackup

" Conditional Settings
" --------------------
if has('nvim')
    set inccommand=nosplit
else
    set ttymouse=xterm2
endif

" Easy switch between light and dark colorscheme
if $BACKGROUND == 'light'
    set background=light
else
    set background=dark
endif

" Use ag for faster searching
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
endif

" Use rg for faster searching (preferred over ag)
if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l,%m
endif

" Key Remappings
" --------------
let mapleader="\<SPACE>"

nnoremap Y y$
nnoremap <silent> <LEADER><SPACE> :nohlsearch<CR>
nnoremap <silent> <LEADER>s :StripWhitespace<CR>
nmap <silent> <LEADER>j <Plug>(coc-git-nextchunk)
nmap <silent> <LEADER>k <Plug>(coc-git-prevchunk)
nmap <silent> <LEADER>d <Plug>(coc-definition)
nmap <silent> <LEADER>i <Plug>(coc-implementation)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> <LEADER>gs :CocCommand git.chunkStage<CR>
nmap <LEADER>c yygccp

inoremap <silent><expr> <C-l> delimitMate#JumpAny()

vnoremap < <gv
vnoremap > >gv

nnoremap <silent> <TAB> :call <SID>n_tab()<CR>
nnoremap <silent> <S-TAB> :call <SID>n_stab()<CR>
inoremap <silent> <TAB> <C-R>=(<SID>i_tab())<CR>
inoremap <silent> <S-TAB> <C-R>=(<SID>i_stab())<CR>
inoremap <silent> <CR> <C-R>=(<SID>i_cr())<CR>
snoremap <silent> <TAB> <C-g>:<C-u>call UltiSnips#JumpForwards()<CR>
snoremap <silent> <S-TAB> <C-g>:<C-u>call UltiSnips#JumpBackwards()<CR>

" Functions
" ---------
function! s:check_prev_whitespace()
    let c = col('.') - 1
    return !c || getline('.')[c - 1] =~# '\s'
endfunction

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

let g:ulti_jump_forwards_res = 0
function! s:ulti_jump_forwards()
    call UltiSnips#JumpForwards()
    return g:ulti_jump_forwards_res
endfunction

let g:ulti_jump_backwards_res = 0
function! s:ulti_jump_backwards()
    call UltiSnips#JumpBackwards()
    return g:ulti_jump_backwards_res
endfunction

let g:ulti_expand_or_jump_res = 0
function! s:ulti_expand_or_jump()
    call UltiSnips#ExpandSnippetOrJump()
    return g:ulti_expand_or_jump_res
endfunction

function! s:n_tab()
    if <SID>ulti_jump_forwards() == 0
        normal gt
    endif
endfunction

function! s:n_stab()
    if <SID>ulti_jump_backwards() == 0
        normal gT
    endif
endfunction

function! s:i_tab()
    return pumvisible() ? "\<C-n>" :
         \ <SID>ulti_jump_forwards() ? "" :
         \ <SID>check_prev_whitespace() ? "\<TAB>" :
         \ coc#refresh()
endfunction

function! s:i_stab()
    return pumvisible() ? "\<C-p>" : UltiSnips#JumpBackwards()
endfunction

function! s:i_cr()
    return <SID>ulti_expand_or_jump() ? "" :
         \ pumvisible() ? "\<C-]>" :
         \ "\<CR>"
endfunction

function! LightlineGitInfo()
    let branch = get(g:, 'coc_git_status', '')
    let status = get(b:, 'coc_git_status', '')
    let status = substitute(status, '  ', '', '')
    return status . branch
endfunction

function! LightlineFilename()
    let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
    let modified = &modified ? ' +' : ''
    return filename . modified
endfunction

" function parameter hints using UltiSnips
function! s:function_parameter_hint()
    if !exists('v:completed_item') || empty(v:completed_item)
        return
    endif
    if v:completed_item.word == ''
        return
    endif
    let abbr = v:completed_item.abbr
    let startIdx = match(abbr,"(")
    let endIdx = match(abbr,")")
    let angle = 0
    if startIdx == -1 || endIdx == -1
        let startIdx = match(abbr,"<")
        let endIdx = match(abbr,">")
        let angle = 1
    endif
    if endIdx - startIdx > 1
        let argsStr = strpart(abbr, startIdx+1, endIdx-startIdx-1)
        let argsList = split(argsStr, ",")
        let snippet = angle ? "<" : "("
        let c = 1
        for i in argsList
            if c > 1
                let snippet = snippet. ", "
            endif
            " strip space
            let arg = substitute(i, '^\s*\(.\{-}\)\s*$', '\1', '')
            let snippet = snippet . '${'.c.":".arg.'}'
            let c += 1
        endfor
        let snippet = angle ? snippet.">$0" : snippet.")$0"
        call UltiSnips#Anon(snippet)
    elseif endIdx - startIdx == 1
        call UltiSnips#Anon("()$0")
    endif
endfunction

" Autocommands
" ------------

" Give function parameter hints after finishing completion
autocmd CompleteDone * call <SID>function_parameter_hint()

" Highlight hovered text
autocmd CursorHold * silent call CocActionAsync('highlight')

" Set filetype to text if not already set
autocmd BufEnter * if &filetype == "" | setlocal ft=text | endif

" Cursorline moves with buffers and hides during insert
augroup CursorLine
    autocmd!
    autocmd BufWinEnter * setl cursorline
    autocmd InsertEnter * setl nocursorline
    autocmd InsertLeave * setl cursorline
    autocmd VimEnter * setl cursorline
    autocmd WinEnter * setl cursorline
    autocmd WinLeave * setl nocursorline
augroup END

" Plugins
" -------
call plug#begin('~/.vim/plugins')

if $OS == 'Mac'
    Plug 'https://github.com/junegunn/fzf.git', { 'dir': '~/.fzf', 'do': './install --all' }
elseif $OS == 'Linux'
    Plug 'https://github.com/junegunn/fzf.git'
endif

Plug 'https://github.com/altercation/vim-colors-solarized.git'
Plug 'https://github.com/christoomey/vim-tmux-navigator.git'
Plug 'https://github.com/itchyny/lightline.vim.git'
Plug 'https://github.com/junegunn/fzf.vim.git'
Plug 'https://github.com/junegunn/vim-easy-align.git'
Plug 'https://github.com/justinmk/vim-sneak.git'
Plug 'https://github.com/mrtazz/DoxygenToolkit.vim.git', { 'on': 'Dox' }
Plug 'https://github.com/neoclide/coc.nvim.git', {'branch': 'release'}
Plug 'https://github.com/ntpeters/vim-better-whitespace.git'
Plug 'https://github.com/numirias/semshi.git', { 'do': ':UpdateRemotePlugins' }
Plug 'https://github.com/Raimondi/delimitMate.git'
Plug 'https://github.com/SirVer/ultisnips.git'
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/tpope/vim-obsession.git'
Plug 'https://github.com/tpope/vim-repeat.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/wellle/targets.vim.git'
Plug 'https://github.com/w0rp/ale.git'

call plug#end()

" Plugin Configurations
" ---------------------
" Colorscheme
let g:solarized_termtrans=1
let g:solarized_termcolors=256
colorscheme solarized

" Lightline
set laststatus=2
set t_Co=256
let g:lightline={
    \ 'colorscheme': 'solarized',
    \ 'active':{
    \   'left':[['mode','paste'],['readonly','filename']],
    \   'right':[['lineinfo'],['fileencoding','fileformat','filetype'],['git']]
    \ },
    \ 'component_function':{
    \   'filename':'LightlineFilename',
    \   'git':'LightlineGitInfo',
    \ },
    \ 'separator':{
    \   'left':'',
    \   'right':''
    \ },
    \ 'subseparator':{
    \   'left':'',
    \   'right':''
    \ }
    \ }

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" FZF
nnoremap <LEADER>p :FZFFiles<CR>
let g:fzf_nvim_statusline=0
let g:fzf_command_prefix='FZF'
let g:fzf_layout={ 'left': '~30%' }
let g:fzf_action={
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-h': 'split',
    \ 'ctrl-v': 'vsplit',
    \ }

" Vim-Better-Whitespace
highlight ExtraWhitespace ctermbg=darkred guibg=darkred
let g:better_whitespace_filetypes_blacklist=['diff', 'mail']

" Sneak
let g:sneak#s_next=1

" coc
let g:coc_global_extensions=['coc-git',
                           \ 'coc-ultisnips'
                           \ ]
highlight CocHighlightText ctermfg=White ctermbg=DarkMagenta

" UltiSnips
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsSnippetsDir='~/.config/ultisnips'
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/ultisnips']
let g:UltiSnipsExpandTrigger='<F13>'
let g:UltiSnipsJumpForwardTrigger='<F14>'
let g:UltiSnipsJumpBackwardTrigger='<F15>'
let g:UltiSnipsRemoveSelectModeMappings=0

" ALE
let g:ale_linters={
    \ 'c': ['cppcheck'],
    \ 'cpp': ['cppcheck']
    \ }
let g:ale_fixers={
    \ 'c': ['clang-format'],
    \ 'cpp': ['clang-format']
    \ }
let g:ale_linters_explicit=1
let g:ale_fix_on_save=1
let g:ale_sign_error = '😡'
let g:ale_sign_warning = '🤔'
