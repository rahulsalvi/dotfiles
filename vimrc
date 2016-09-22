set backspace=indent,eol,start
set cursorline
set expandtab
set hlsearch
set incsearch
set mouse=a
set number
set relativenumber
set selection=exclusive
set shiftwidth=4
set showcmd
set sidescroll=1
set splitbelow
set splitright
set tabstop=4

set nobackup
set nocompatible
set noshowmode
set noswapfile
set nowrap
set nowritebackup

autocmd BufEnter * if &filetype == "" | setlocal ft=text | endif

if !has('nvim')
    set ttymouse=xterm2
endif

if $BACKGROUND == 'light'
    set background=light
else
    set background=dark
endif

aug CursorLine
    autocmd!
    autocmd BufWinEnter * setl cursorline
    autocmd InsertEnter * setl nocursorline
    autocmd InsertLeave * setl cursorline
    autocmd VimEnter * setl cursorline
    autocmd WinEnter * setl cursorline
    autocmd WinLeave * setl nocursorline
aug END

map <SPACE> <LEADER>

nnoremap Y y$
nnoremap <TAB> gt
nnoremap <S-TAB> gT
nmap <BS> <C-^>

vnoremap < <gv
vnoremap > >gv

" Function parameter completion using YouCompleteMe and UltiSnips
function! FunctionParameterHint()
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
        let argsStr = strpart(abbr, startIdx + 1, endIdx - startIdx - 1)
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
        let snippet = angle ? snippet . ">$0" : snippet . ")$0"
        call UltiSnips#Anon(snippet)
    elseif endIdx - startIdx == 1
        call UltiSnips#Anon("()$0")
    endif
endfunction
autocmd CompleteDone * call FunctionParameterHint()

" Use enter to expand functions or snippets
function! ExpandFunctionOrSnippet()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-y>"
        else
            return "\<CR>"
        endif
    endif
    return ""
endfunction

" Both vim and neovim can source their plugins from the same directory
call plug#begin('~/.vim/plugins')

Plug 'https://github.com/altercation/vim-colors-solarized.git'
Plug 'https://github.com/bronson/vim-trailing-whitespace.git'
Plug 'https://github.com/christoomey/vim-tmux-navigator.git'
Plug 'https://github.com/junegunn/fzf.git', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'https://github.com/junegunn/fzf.vim.git'
Plug 'https://github.com/junegunn/vim-easy-align.git'
Plug 'https://github.com/justinmk/vim-sneak.git'
Plug 'https://github.com/mphe/grayout.vim.git'
Plug 'https://github.com/mrtazz/DoxygenToolkit.vim.git', { 'on': 'Dox' }
Plug 'https://github.com/Raimondi/delimitMate.git'
Plug 'https://github.com/SirVer/ultisnips.git'
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/tpope/vim-dispatch.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/tpope/vim-obsession.git'
Plug 'https://github.com/tpope/vim-repeat.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/Valloric/ListToggle.git'
Plug 'https://github.com/Valloric/YouCompleteMe.git', { 'do': './install.py --clang-completer' }
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
Plug 'https://github.com/wellle/targets.vim.git'

call plug#end()

" Plugin Configurations

" Ag
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:unite_source_grep_command='ag'
    let g:unite_source_grep_default_opts =
                \ '-i --vimgrep --hidden --ignore ' .
                \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    let g:unite_source_grep_recursive_opt=''
endif

" Airline
let g:airline_theme='solarized'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='|'
let g:airline#extensions#ycm#enabled=1
let g:airline#extensions#ycm#error_symbol='E:'
let g:airline#extensions#ycm#warning_symbol='W:'
let g:airline_solarized_bg=&background
set ttimeoutlen=50
set laststatus=2

" Colorscheme
let g:solarized_termtrans=1
let g:solarized_termcolors=256
try
    colorscheme solarized
catch
endtry

" delimitMate
let g:delimitMate_expand_cr=1

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" FZF
nnoremap <LEADER>p :FZFFiles <ENTER>
let g:fzf_nvim_statusline=0
let g:fzf_command_prefix='FZF'
let g:fzf_layout={ 'left': '~30%' }
let g:fzf_action={
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-h': 'split',
  \ 'ctrl-v': 'vsplit' }

" ListToggle
let g:lt_location_list_toggle_map='<LEADER>l'
let g:lt_quickfix_list_toggle_map='<LEADER>k'

" Sneak
let g:sneak#s_next=1

" UltiSnips
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsSnippetsDir='~/Dropbox/UltiSnips'
let g:UltiSnipsSnippetDirectories=[$HOME.'/Dropbox/UltiSnips']
let g:UltiSnipsExpandTrigger='<ENTER>'
let g:UltiSnipsJumpForwardTrigger='<TAB>'
let g:UltiSnipsJumpBackwardTrigger='<S-TAB>'
au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=ExpandFunctionOrSnippet()<CR>"

" YouCompleteMe
let g:ycm_key_invoke_completion='<M-l>'
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
let g:ycm_error_symbol='E>'
let g:ycm_warning_symbol='W>'
let g:ycm_always_populate_location_list=1
let g:ycm_max_diagnostics_to_display=1000
let g:ycm_python_binary_path='python3'
let g:ycm_filetype_blacklist={}
let g:ycm_add_preview_to_completeopt=0
map <LEADER><SPACE> :YcmCompleter<SPACE>
set completeopt-=preview
