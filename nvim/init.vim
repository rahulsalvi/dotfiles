" General Settings
" ----------------
set backspace=indent,eol,start
set clipboard=unnamedplus
set expandtab
set hlsearch
set incsearch
set lazyredraw
set modeline
set modelines=1
set mouse=a
set number
set relativenumber
set scrolloff=5
set selection=exclusive
set shiftwidth=4
set showcmd
set sidescroll=1
set signcolumn=yes
set softtabstop=4
set splitbelow
set splitright
set tabstop=4
set updatetime=300
set virtualedit=all
set wildmenu

set nobackup
set nocompatible
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
let maplocalleader="\<SPACE>"

" general
nnoremap Y y$
nnoremap <LEADER>p :FZFFiles<CR>
nmap <LEADER>c yygccp
nnoremap <silent> <LEADER><SPACE> :nohlsearch<CR>
nnoremap <silent> <LEADER>s :StripWhitespace<CR>
inoremap <silent><expr> <C-l> delimitMate#JumpAny()

" coc
nmap <silent> <LEADER>j <Plug>(coc-git-nextchunk)
nmap <silent> <LEADER>k <Plug>(coc-git-prevchunk)
nmap <silent> <LEADER>d <Plug>(coc-definition)
nmap <silent> <LEADER>i <Plug>(coc-implementation)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> <LEADER>gs :CocCommand git.chunkStage<CR>

" Vista
nnoremap <silent> <LEADER>b :Vista!!<CR>
nnoremap <silent> <LEADER>v :Vista finder fzf:coc<CR>

" links
nnoremap <silent> <LEADER>le :Utl openLink underCursor e<CR>
nnoremap <silent> <LEADER>lv :Utl openLink underCursor vsp<CR>
nnoremap <silent> <LEADER>ls :Utl openLink underCursor sp<CR>
nnoremap <silent> <LEADER>lt :Utl openLink underCursor tabe<CR>

" terminal
nnoremap <silent> <LEADER>t :Ttoggle<CR>
nnoremap <silent> <LEADER>y :call <SID>neoterm_start("python")<CR>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <C-w> <C-\><C-n>:Ttoggle<CR>
tnoremap <C-q> <C-\><C-n>:Tclose!<CR>

" tab/cr keys
nnoremap <silent> <TAB> :call <SID>n_tab()<CR>
nnoremap <silent> <S-TAB> :call <SID>n_stab()<CR>
inoremap <silent> <TAB> <C-R>=(<SID>i_tab())<CR>
inoremap <silent> <S-TAB> <C-R>=(<SID>i_stab())<CR>
inoremap <silent> <CR> <C-R>=(<SID>i_cr())<CR>
snoremap <silent> <TAB> <C-g>:<C-u>call UltiSnips#JumpForwards()<CR>
snoremap <silent> <S-TAB> <C-g>:<C-u>call UltiSnips#JumpBackwards()<CR>

" visual
vnoremap < <gv
vnoremap > >gv

" vimspector
nmap <F3> :VimspectorReset<CR>
nmap <F4> <Plug>VimspectorRestart
nmap <F5> <Plug>VimspectorContinue
nmap <F9> <Plug>VimspectorToggleBreakpoint
nmap <F10> <Plug>VimspectorStepOver
nmap <F11> <Plug>VimspectorStepInto
nmap <F12> <Plug>VimspectorStepOut
nnoremap <LEADER>vw :VimspectorWatch 
nnoremap <LEADER>ve :VimspectorEval 

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
         \ delimitMate#WithinEmptyPair() ? delimitMate#ExpandReturn() :
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
    let modified = &modified ? ' +' : ''
    let root = fnamemodify(get(b:, 'git_dir'), ':h')
    let fugitive_root = 'fugitive://' . root
    let path = expand('%:p')
    if path[:len(root)-1] ==# root
        return path[len(root)+1:] . modified
    elseif path[:len(fugitive_root)-1] ==# fugitive_root
        return path[len(fugitive_root)+1:] . modified
    else
        let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
        return filename . modified
    endif
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

function! s:neoterm_start(shell)
    let prev = g:neoterm_shell
    let g:neoterm_shell = a:shell
    execute 'Tnew'
    let g:neoterm_shell = prev
endfunction

function! s:neoterm_exec(shell, cmd)
    let prev = g:neoterm_shell
    let g:neoterm_shell = a:shell
    execute 'T ' . a:cmd
    let g:neoterm_shell = prev
endfunction

function! s:goyo_enter()
    set textwidth=0
    set wrapmargin=0
    set wrap
    set linebreak
    set nolist
    nnoremap j gj
    nnoremap k gk
    nnoremap $ g$
    nnoremap 0 g0
    let b:quitting = 0
    let b:quitting_bang = 0
    autocmd QuitPre <buffer> let b:quitting = 1
    cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
    set nowrap
    nunmap j
    nunmap k
    nunmap $
    nunmap 0
    highlight SignColumn ctermbg=None
    highlight Folded cterm=bold ctermbg=None
    if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        if b:quitting_bang
            qa!
        else
            qa
        endif
    endif
endfunction

function! CreateBorderedFloatingWindow()
    let height = float2nr(&lines * 0.6)
    let width = float2nr(&columns * 0.8)
    let horizontal=float2nr((&columns - width) / 2)
    let vertical = 1
    let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
    \ }
    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
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

autocmd FileType org setlocal foldlevel=1
autocmd BufWinEnter *.org nunmap <buffer> <localleader>pa
autocmd BufWinEnter *.org nunmap <buffer> <localleader>pi

autocmd BufReadPost fugitive://* set bufhidden=delete

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

autocmd! VimEnter /tmp/neomutt-* :Goyo

" enter terminals in insert mode
if has('nvim')
    autocmd TermOpen term://* startinsert
    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd BufLeave term://* stopinsert
endif

" Plugins
" -------
call plug#begin('~/.config/nvim/plugins')

Plug 'https://github.com/altercation/vim-colors-solarized.git'
Plug 'https://github.com/christoomey/vim-tmux-navigator.git'
Plug 'https://github.com/dense-analysis/ale.git'
Plug 'https://github.com/itchyny/lightline.vim.git'
Plug 'https://github.com/jackguo380/vim-lsp-cxx-highlight.git'
Plug 'https://github.com/jceb/vim-orgmode.git'
Plug 'https://github.com/junegunn/fzf.git'
Plug 'https://github.com/junegunn/fzf.vim.git'
Plug 'https://github.com/junegunn/goyo.vim.git'
Plug 'https://github.com/junegunn/vim-easy-align.git'
Plug 'https://github.com/justinmk/vim-sneak.git'
Plug 'https://github.com/kassio/neoterm.git'
Plug 'https://github.com/knubie/vim-kitty-navigator.git'
Plug 'https://github.com/liuchengxu/vista.vim.git'
Plug 'https://github.com/mrtazz/DoxygenToolkit.vim.git', { 'on': 'Dox' }
Plug 'https://github.com/neoclide/coc.nvim.git', {'branch': 'release'}
Plug 'https://github.com/ntpeters/vim-better-whitespace.git'
Plug 'https://github.com/numirias/semshi.git', { 'do': ':UpdateRemotePlugins' }
Plug 'https://github.com/puremourning/vimspector.git'
Plug 'https://github.com/Raimondi/delimitMate.git'
Plug 'https://github.com/rhysd/clever-f.vim.git'
Plug 'https://github.com/SirVer/ultisnips.git'
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/tpope/vim-obsession.git'
Plug 'https://github.com/tpope/vim-repeat.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/vim-scripts/utl.vim.git'
Plug 'https://github.com/wellle/targets.vim.git'

call plug#end()

" Plugin Configurations
" ---------------------
" Colorscheme
let g:solarized_termtrans=1
let g:solarized_termcolors=256
colorscheme solarized
highlight SignColumn ctermbg=None
highlight Folded cterm=bold ctermbg=None
highlight NormalFloat ctermbg=Black ctermfg=White

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

" vim-orgmode
let g:org_agenda_files = ['~/todo/*.org']
let g:org_todo_keywords = [
    \ ['TODO(t)', 'IN_PROGRESS(i)', '|', 'DONE(d)'],
    \ ['PLANNED(p)', 'PARTS_READY(r)', 'WORKING(w)', '|', 'DONE(d)'],
    \ ]
let g:org_prefer_insert_mode = 0
let g:org_heading_shade_leading_stars = 0

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" FZF
let g:fzf_nvim_statusline=0
let g:fzf_command_prefix='FZF'
let g:fzf_layout={ 'window': 'call CreateBorderedFloatingWindow()' }
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

" neoterm
let g:neoterm_size='20%'
let g:neoterm_autojump=1
let g:neoterm_default_mod='botright'

" Vista
let g:vista_default_executive='coc'
let g:vista_close_on_jump=1
let g:vista_sidebar_width=40
let g:vista#renderer#enable_icon=1
let g:vista#renderer#icons={
    \ 'function': 'λ',
    \ 'variable': ''
    \ }

" coc
let g:coc_global_extensions=['coc-git',
                           \ 'coc-ultisnips',
                           \ 'coc-python',
                           \ 'coc-texlab'
                           \ ]
highlight CocHighlightText ctermfg=White ctermbg=DarkMagenta

" clever-f
let g:clever_f_across_no_line=1
let g:clever_f_smart_case=1

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
    \ 'cpp': ['cppcheck'],
    \ 'python': ['pylint'],
    \ 'sh': ['shellcheck'],
    \ 'tex': ['chktex'],
    \ }
let g:ale_fixers={
    \ 'c': ['clang-format'],
    \ 'cpp': ['clang-format'],
    \ 'python': ['yapf'],
    \ 'sh': ['shfmt'],
    \ }
let g:ale_linters_explicit=1
let g:ale_fix_on_save=1
let g:ale_sign_error = '😡'
let g:ale_sign_warning = '🤔'
let g:ale_echo_msg_format='[%linter%] %code: %%s'
