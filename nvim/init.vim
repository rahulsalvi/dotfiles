" General Settings
" ----------------
set backspace=indent,eol,start
set clipboard=unnamedplus
set completeopt=menuone,noselect
set expandtab
set hlsearch
set inccommand=nosplit
set incsearch
set lazyredraw
set modeline
set modelines=1
set mouse=a
set number
set relativenumber
set scrolloff=5
set shiftwidth=4
set showcmd
set sidescroll=1
set signcolumn=yes
set softtabstop=4
set splitbelow
set splitright
set tabstop=4
set termguicolors
set title
set updatetime=300
set virtualedit=all
set wildmenu

set nobackup
set nocompatible
set noshowmode
set noswapfile
set nowrap
set nowritebackup

let &titlestring="nvim"

" Easy switch between light and dark colorscheme
if $BACKGROUND == 'light'
    set background=light
else
    set background=dark
endif

" Use rg for faster searching
if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l,%m
endif

" Key Remappings
" --------------
" leader
let mapleader="\<SPACE>"
let maplocalleader="\<SPACE>"
nnoremap <silent> <LEADER>      :<c-u>WhichKey '<SPACE>'<CR>
nnoremap <silent> <LOCALLEADER> :<c-u>WhichKey '<SPACE>'<CR>
vnoremap <silent> <LEADER>      :<c-u>WhichKeyVisual '<SPACE>'<CR>
vnoremap <silent> <LOCALLEADER> :<c-u>WhichKeyVisual '<SPACE>'<CR>

" general
nnoremap Y y$
nnoremap <LEADER>p :FZFFiles<CR>
nmap <LEADER>c yygccp
nnoremap <silent> <LEADER><SPACE> :nohlsearch<CR>
nnoremap <silent> <LEADER>s :StripWhitespace<CR>
inoremap <silent><expr> <C-l> delimitMate#JumpAny()
inoremap <silent><expr> <C-e> compe#close('<C-e>')
nnoremap <LEADER>a :BufferPick<CR>
vnoremap < <gv
vnoremap > >gv

" git
nmap <LEADER>j <Plug>(GitGutterNextHunk)
nmap <LEADER>k <Plug>(GitGutterPrevHunk)
nmap <LEADER>gs <Plug>(GitGutterStageHunk)
nmap <LEADER>gu <Plug>(GitGutterUndoHunk)

" Vista
nnoremap <silent> <LEADER>b :Vista!!<CR>
nnoremap <silent> <LEADER>P :Vista finder fzf:nvim_lsp<CR>

" terminal
nnoremap <silent> <LEADER>t :Ttoggle<CR>
nnoremap <silent> <LEADER>T :call <SID>neoterm_start("python")<CR>
tnoremap <C-n> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <C-w> <C-\><C-n>:Ttoggle<CR>
tnoremap <C-q> <C-\><C-n>:Tclose!<CR>

" tab/cr keys
nmap <silent> <TAB> :call <SID>n_tab()<CR>
nmap <silent> <S-TAB> :call <SID>n_stab()<CR>
imap <silent><expr> <TAB> <SID>i_tab()
imap <silent><expr> <S-TAB> <SID>i_stab()
imap <silent><expr> <CR> <SID>i_cr()
smap <silent><expr> <TAB> vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<TAB>"
smap <silent><expr> <S-TAB> vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<TAB>"

" define bindings for vim-which-key
let g:leader_key_map={
    \ 'name' : 'leader',
    \ 'a'    : [ ':BufferPick',                        'change-buffer'             ],
    \ 'b'    : [ ':Vista!!',                           'toggle-vista'              ],
    \ 'c'    : [ 'yygccp',                             'copy-comment-current-line' ],
    \ 'd'    : [ 'GotoDefinition()',                   'go-to-definition'          ],
    \ 'j'    : [ '<Plug>(GitGutterNextHunk)',          'git-next-chunk'            ],
    \ 'k'    : [ '<Plug>(GitGutterPrevHunk)',          'git-previous-chunk'        ],
    \ 'P'    : [ ':Vista finder fzf:nvim_lsp',         'vista-finder'              ],
    \ 'p'    : [ ':FZFFiles',                          'fzf-files'                 ],
    \ 'r'    : [ ':Lspsaga rename',                    'rename'                    ],
    \ 's'    : [ ':StripWhitespace',                   'strip-whitespace'          ],
    \ 'T'    : [ ':call <SID>neoterm_start("python")', 'python-interpreter'        ],
    \ 't'    : [ ':Ttoggle',                           'toggle-terminal'           ],
    \ }
let g:leader_key_map['g']={
    \ 'name' : '+git',
    \ 's'    : [ '<Plug>(GitGutterStageHunk)', 'git-stage-chunk' ],
    \ 'u'    : [ '<Plug>(GitGutterUndoHunk)',  'git-stage-chunk' ],
    \ }

" Functions
" ---------
function! GotoDefinition()
    lua vim.lsp.buf.definition()
endfunction

function! s:check_prev_whitespace()
    let c = col('.') - 1
    return !c || getline('.')[c - 1] =~# '\s'
endfunction

function! s:n_tab()
    if vsnip#jumpable(1)
        execute "normal i\<Plug>(vsnip-jump-next)"
    else
        normal gt
    endif
endfunction

function! s:n_stab()
    if vsnip#jumpable(-1)
        execute "normal i\<Plug>(vsnip-jump-prev)"
    else
        normal gT
    endif
endfunction

function! s:i_tab()
    return
        \ pumvisible() ? "\<C-n>" :
        \ vsnip#jumpable(1) ? "\<Plug>(vsnip-jump-next)" :
        \ <SID>check_prev_whitespace() ? "\<TAB>" :
        \ delimitMate#ShouldJump() ? delimitMate#JumpAny() :
        \ compe#complete()
endfunction

function! s:i_stab()
    return
        \ pumvisible() ? "\<C-p>" :
        \ vsnip#jumpable(-1) ? "\<Plug>(vsnip-jump-prev)" :
        \ "\<S-TAB>"
endfunction

function! s:i_cr()
    return
        \ vsnip#expandable() ? "\<Plug>(vsnip-expand)" :
        \ pumvisible() ? compe#confirm("") :
        \ vsnip#available(1) ? "\<Plug>(vsnip-expand-or-jump)" :
        \ delimitMate#WithinEmptyPair() ? "\<Plug>delimitMateCR" :
        \ delimitMate#ShouldJump() ? delimitMate#JumpAny() :
        \ "\<CR>"
endfunction

function! LightlineGitInfo()
    let branch = fugitive#head(8)
    let [a,m,r] = GitGutterGetHunkSummary()
    let added    = a > 0 ? printf("+%d ", a) : ""
    let modified = m > 0 ? printf("~%d ", m) : ""
    let removed  = r > 0 ? printf("-%d ", r) : ""
    return added . modified . removed . branch
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

autocmd TermOpen term://* startinsert
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

" Plugins
" -------
call plug#begin('~/.config/nvim/plugins')

Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/christoomey/vim-tmux-navigator.git'
Plug 'https://github.com/dense-analysis/ale.git'
Plug 'https://github.com/glepnir/lspsaga.nvim'
Plug 'https://github.com/hrsh7th/nvim-compe'
Plug 'https://github.com/hrsh7th/vim-vsnip'
Plug 'https://github.com/ishan9299/nvim-solarized-lua'
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
Plug 'https://github.com/kyazdani42/nvim-web-devicons'
Plug 'https://github.com/liuchengxu/vim-which-key.git'
Plug 'https://github.com/liuchengxu/vista.vim.git'
Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'https://github.com/ntpeters/vim-better-whitespace.git'
Plug 'https://github.com/numirias/semshi.git', { 'do': ':UpdateRemotePlugins' }
Plug 'https://github.com/rahulsalvi/rahulsalvi-snippets'
Plug 'https://github.com/Raimondi/delimitMate.git'
Plug 'https://github.com/ray-x/lsp_signature.nvim'
Plug 'https://github.com/rhysd/clever-f.vim.git'
Plug 'https://github.com/romgrk/barbar.nvim'
Plug 'https://github.com/sirtaj/vim-openscad.git'
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/tpope/vim-obsession.git'
Plug 'https://github.com/tpope/vim-repeat.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/wellle/targets.vim.git'

call plug#end()

" Plugin Configurations
" ---------------------
" Colorscheme
let g:solarized_termtrans=1
colorscheme solarized-high
highlight SignColumn guibg=None
highlight Folded gui=bold guibg=None
highlight NormalFloat guibg=Black guifg=White
highlight LspDiagnosticsDefaultError       gui=NONE guifg=Red
highlight LspDiagnosticsDefaultWarning     gui=NONE guifg=Yellow
highlight LspDiagnosticsDefaultInformation gui=NONE guifg=Cyan
highlight LspDiagnosticsDefaultHint        gui=NONE guifg=Green
highlight! link ALEError            LspDiagnosticsUnderlineError
highlight! link ALEWarning          LspDiagnosticsUnderlineWarning
highlight! link ALEInfo             LspDiagnosticsDefaultInformation
highlight! link ALEStyleError       LspDiagnosticsDefaultError
highlight! link ALEStyleWarning     LspDiagnosticsDefaultWarning
highlight! link ALEErrorSign        LspDiagnosticsSignError
highlight! link ALEWarningSign      LspDiagnosticsSignWarning
highlight! link ALEInfoSign         LspDiagnosticsSignInformation
highlight! link ALEStyleErrorSign   LspDiagnosticsSignError
highlight! link ALEStyleWarningSign LspDiagnosticsSignWarning
sign define LspDiagnosticsSignError       text=😡 texthl=LspDiagnosticsSignError       linehl= numhl=LspDiagnosticsSignError
sign define LspDiagnosticsSignWarning     text=🤔 texthl=LspDiagnosticsSignWarning     linehl= numhl=LspDiagnosticsSignWarning
sign define LspDiagnosticsSignInformation text=I  texthl=LspDiagnosticsSignInformation linehl= numhl=LspDiagnosticsSignInformation
sign define LspDiagnosticsSignHint        text=H  texthl=LspDiagnosticsSignHint        linehl= numhl=LspDiagnosticsSignHint

" vim-gitgutter
let g:gitgutter_map_keys = 0
let g:gitgutter_sign_priority = 0

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
    \ 'cmake': ['cmakeformat'],
    \ 'python': ['yapf'],
    \ 'sh': ['shfmt'],
    \ }
command! ALEToggleFixer execute "let g:ale_fix_on_save = get(g:, 'ale_fix_on_save', 0) ? 0 : 1"
let g:ale_linters_explicit=1
let g:ale_fix_on_save=1
let g:ale_sign_priority = 100
let g:ale_sign_error = '😡'
let g:ale_sign_warning = '🤔'
let g:ale_sign_info = 'I'
let g:ale_sign_style_error = '😡'
let g:ale_sign_style_warning = '🤔'
let g:ale_echo_msg_format='[%linter%] %code: %%s'

" nvim-compe
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'always'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true

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

" vim-lsp-cxx-highlight
let g:lsp_cxx_hl_use_text_props = 1

" vim-orgmode
let g:org_agenda_files = ['~/todo/*.org']
let g:org_todo_keywords = [
    \ ['TODO(t)', 'IN_PROGRESS(i)', '|', 'DONE(d)'],
    \ ['PLANNED(p)', 'PARTS_READY(r)', 'WORKING(w)', '|', 'DONE(d)'],
    \ ]
let g:org_prefer_insert_mode = 0
let g:org_heading_shade_leading_stars = 0

" FZF
let g:fzf_nvim_statusline=0
let g:fzf_command_prefix='FZF'
let g:fzf_layout={ 'window': 'call CreateBorderedFloatingWindow()' }
let g:fzf_action={
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit',
    \ }

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Sneak
let g:sneak#s_next=1

" neoterm
let g:neoterm_size='20%'
let g:neoterm_autojump=1
let g:neoterm_default_mod='botright'

" vim-which-key
let g:which_key_use_floating_win=1
call which_key#register('<SPACE>', "g:leader_key_map")

" Vista
let g:vista_default_executive='nvim_lsp'
let g:vista_close_on_jump=1
let g:vista_sidebar_width=40
let g:vista#renderer#enable_icon=1
let g:vista#renderer#icons={
    \ 'function': 'λ',
    \ 'variable': ''
    \ }

" Vim-Better-Whitespace
highlight ExtraWhitespace ctermbg=darkred guibg=darkred
let g:better_whitespace_filetypes_blacklist=['diff', 'mail']

" clever-f
let g:clever_f_across_no_line=1
let g:clever_f_smart_case=1

" barbar.nvim
let bufferline = get(g:, 'bufferline', {})
let bufferline.auto_hide = v:true
let bufferline.icon_close_tab = '✕'

" Lua Configuration
" -----------------
lua << EOF
-- lspsaga
local saga = require 'lspsaga'
saga.init_lsp_saga {
    error_sign = '😡',
    warn_sign = '🤔',
    rename_prompt_prefix = 'New Name ➤'
}

-- nvim-lspconfig
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', '<LEADER>d', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<LEADER>r', '<Cmd>lua require("lspsaga.rename").rename()<CR>', opts)
  buf_set_keymap('n', 'K',         '<Cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', opts)

  lsp_signature_cfg = {
      hint_prefix = ''
  }

  require'lsp_signature'.on_attach(lsp_signature_cfg)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local nvim_lsp = require('lspconfig')
nvim_lsp.ccls.setup{
    init_options = {
        cache = {
            directory = "/tmp/ccls";
        };
        highlight = {
            lsRanges = true;
        };
    },
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
}

nvim_lsp.pyright.setup{
    on_attach=on_attach
}

nvim_lsp.bashls.setup{}
nvim_lsp.cmake.setup{}
EOF
