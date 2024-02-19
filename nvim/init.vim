" General Settings
" ----------------
set backspace=indent,eol,start
set clipboard=unnamedplus
set completeopt=menuone,noselect
set expandtab
set hidden
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
nnoremap <LEADER>      <Cmd>WhichKey '<SPACE>'<CR>
nnoremap <LOCALLEADER> <Cmd>WhichKey '<SPACE>'<CR>
vnoremap <LEADER>      <Cmd>WhichKeyVisual '<SPACE>'<CR>
vnoremap <LOCALLEADER> <Cmd>WhichKeyVisual '<SPACE>'<CR>

" general
nnoremap Y y$
nnoremap <LEADER>p <Cmd>FZFFiles<CR>
nnoremap <LEADER><SPACE> <Cmd>nohlsearch<CR>
nnoremap <LEADER>s <Cmd>StripWhitespace<CR>
nnoremap <LEADER>z <Cmd>tab sp<CR>
nnoremap <LEADER>a <Cmd>NvimTreeToggle<CR>
nnoremap <LEADER>f <Cmd>FZFRg<CR>
nnoremap <LEADER>gl <Cmd>lua _lazygit_toggle()<CR>
nnoremap <LEADER>T <Cmd>lua _python_toggle()<CR>
nmap <LEADER>c yygccp
inoremap <expr> <C-l> delimitMate#JumpAny()
inoremap <expr> <C-e> compe#close('<C-e>')
vnoremap < <gv
vnoremap > >gv

" Vista
nnoremap <LEADER>v <Cmd>Vista!!<CR>
nnoremap <LEADER>P <Cmd>Vista finder fzf:nvim_lsp<CR>

" terminal
tnoremap <C-n> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" tab/cr keys
nmap <TAB> <Cmd>call <SID>n_tab()<CR>
nmap <S-TAB> <Cmd>call <SID>n_stab()<CR>
imap <expr> <TAB> <SID>i_tab()
imap <expr> <S-TAB> <SID>i_stab()
imap <expr> <CR> <SID>i_cr()
smap <expr> <TAB> vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<TAB>"
smap <expr> <S-TAB> vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<TAB>"

" define bindings for vim-which-key
let g:leader_key_map={
    \ 'name' : 'leader',
    \ ' '    : [ ':nohlsearch',                        'nohlsearch'                ],
    \ 'a'    : [ ':NvimTreeToggle',                    'nvim-tree-toggle'          ],
    \ 'c'    : [ 'yygccp',                             'copy-comment-current-line' ],
    \ 'd'    : [ 'GotoDefinition()',                   'go-to-definition'          ],
    \ 'f'    : [ ':FZFRg',                             'fzf-rg'                    ],
    \ 'j'    : [ ':Gitsigns next_hunk',                'git-next-hunk'             ],
    \ 'k'    : [ ':Gitsigns prev_hunk',                'git-prev-hunk'             ],
    \ 'P'    : [ ':Vista finder fzf:nvim_lsp',         'vista-finder'              ],
    \ 'p'    : [ ':FZFFiles',                          'fzf-files'                 ],
    \ 'r'    : [ ':Lspsaga rename',                    'rename'                    ],
    \ 's'    : [ ':StripWhitespace',                   'strip-whitespace'          ],
    \ 'v'    : [ ':Vista!!',                           'toggle-vista'              ],
    \ 'z'    : [ ':tab sp',                            'fullscreen'                ],
\ }
let g:leader_key_map['g']={
    \ 'name' : '+git',
    \ 'b'    : [ ':Gitsigns blame_line',       'git-blame-line'   ],
    \ 'p'    : [ ':Gitsigns preview_hunk',     'git-preview-hunk' ],
    \ 'R'    : [ ':Gitsigns reset_buffer',     'git-reset-buffer' ],
    \ 'r'    : [ ':Gitsigns reset_hunk',       'git-reset-hunk'   ],
    \ 's'    : [ ':Gitsigns stage_hunk',       'git-stage-hunk'   ],
    \ 'u'    : [ ':Gitsigns undo_stage_hunk',  'git-undo-hunk'    ],
\ }
let g:leader_key_map['o']={
    \ 'name' : '+orgmode',
    \ 'a'    : [ 'OrgmodeAgenda()',   'orgmode-agenda'  ],
    \ 'c'    : [ 'OrgmodeCapture()',  'orgmode-capture' ],
\ }

" Functions
" ---------
function! GotoDefinition()
    lua vim.lsp.buf.definition()
endfunction

function! OrgmodeAgenda()
    lua require("orgmode").action("agenda.prompt")
endfunction

function! OrgmodeCapture()
    lua require("orgmode").action("capture.prompt")
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
    let branch = FugitiveHead(8)
    let status = get(b:,'gitsigns_status','')
    return status . ' ' . branch
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
" Fix terminal resizing issue
autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"

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

" Default to showing contents
autocmd BufWinEnter *.org :lua require('orgmode').action('org_mappings.global_cycle')
autocmd BufWinEnter *.org set conceallevel=2
autocmd BufWinEnter *.org set concealcursor=nc

autocmd BufReadPost fugitive://* set bufhidden=delete

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

autocmd! VimEnter /tmp/neomutt-* :Goyo

autocmd TermOpen term://* startinsert
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

" vimwiki/taskwiki
autocmd FileType vimwiki set foldlevel=99

" Highlight yanked text
autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=700 }

" ledger bindings
autocmd FileType ledger nnoremap { ?^\d<CR>
autocmd FileType ledger nnoremap } /^\d<CR>
autocmd FileType ledger nnoremap <LEADER>s <Cmd>call ledger#transaction_state_toggle(line('.'), ' *!')<CR>
autocmd FileType ledger vnoremap <silent> <TAB> :LedgerAlign<CR>
autocmd FileType ledger inoremap <silent> <TAB> <C-r>=ledger#autocomplete_and_align()<CR>

" Plugins
" -------
call plug#begin('~/.config/nvim/plugins')

Plug 'https://github.com/akinsho/org-bullets.nvim.git'
Plug 'https://github.com/akinsho/nvim-toggleterm.lua.git'
Plug 'https://github.com/christoomey/vim-tmux-navigator.git'
Plug 'https://github.com/dense-analysis/ale.git'
Plug 'https://github.com/hrsh7th/nvim-compe'
Plug 'https://github.com/hrsh7th/vim-vsnip'
Plug 'https://github.com/ishan9299/nvim-solarized-lua'
Plug 'https://github.com/itchyny/lightline.vim.git'
Plug 'https://github.com/jackguo380/vim-lsp-cxx-highlight.git'
Plug 'https://github.com/junegunn/fzf.git'
Plug 'https://github.com/junegunn/fzf.vim.git'
Plug 'https://github.com/junegunn/goyo.vim.git'
Plug 'https://github.com/junegunn/vim-easy-align.git'
Plug 'https://github.com/justinmk/vim-sneak.git'
Plug 'https://github.com/kyazdani42/nvim-web-devicons'
Plug 'https://github.com/kyazdani42/nvim-tree.lua'
Plug 'https://github.com/ledger/vim-ledger.git'
Plug 'https://github.com/lewis6991/gitsigns.nvim'
Plug 'https://github.com/liuchengxu/vim-which-key.git'
Plug 'https://github.com/liuchengxu/vista.vim.git'
Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'https://github.com/ntpeters/vim-better-whitespace.git'
Plug 'https://github.com/numirias/semshi.git', { 'do': ':UpdateRemotePlugins' }
Plug 'https://github.com/nvim-lua/plenary.nvim'
Plug 'https://github.com/nvim-orgmode/orgmode.git'
Plug 'https://github.com/nvim-treesitter/nvim-treesitter.git', { 'do': ':TSUpdate' }
Plug 'https://github.com/pearofducks/ansible-vim'
Plug 'https://github.com/rahulsalvi/rahulsalvi-snippets'
Plug 'https://github.com/Raimondi/delimitMate.git'
Plug 'https://github.com/ray-x/lsp_signature.nvim'
Plug 'https://github.com/rhysd/clever-f.vim.git'
Plug 'https://github.com/sirtaj/vim-openscad'
Plug 'https://github.com/tools-life/taskwiki'
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/tpope/vim-obsession.git'
Plug 'https://github.com/tpope/vim-repeat.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/vimwiki/vimwiki'
Plug 'https://github.com/wellle/targets.vim.git'

call plug#end()

" Plugin Configurations
" ---------------------
" Colorscheme
let g:solarized_termtrans=1
colorscheme solarized-high
highlight SignColumn guibg=None
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
highlight! GitSignsAdd gui=NONE guibg=NONE guifg=#859900
highlight! GitSignsChange gui=NONE guibg=NONE guifg=#b58900
highlight! GitSignsDelete gui=NONE guibg=NONE guifg=#dc322f
highlight! OrgHideLeadingStars gui=NONE guibg=NONE guifg=#001e26
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
    \ 'yaml': ['prettier'],
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

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.orgmode = v:true

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

" nvim-tree
let g:nvim_tree_width = '30%'

" vim-ledger
let g:ledger_extra_options='--pedantic --explicit'
let g:ledger_default_commodity='USD'
let g:ledger_commodity_before=0
let g:ledger_commodity_sep=' '
let g:ledger_date_format='%Y-%m-%d'
let g:ledger_align_at=70

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

" vimwiki/taskwiki
let g:taskwiki_taskrc_location='~/.config/task/taskrc'
let g:taskwiki_dont_preserve_folds=1
let g:vimwiki_dir_link='index'
let wiki = {}
let wiki.syntax = 'markdown'
let wiki.ext = '.md'
let wiki.path='~/Documents/taskwarrior/wiki'
let wiki.diary_index='index'
let wiki.diary_start_week_day='sunday'
let wiki.auto_diary_index=1
let g:vimwiki_list = [wiki]
highlight VimwikiHeader1 gui=bold guifg=#cb4b16
highlight VimwikiHeader2 gui=bold guifg=#2aa198
highlight VimwikiHeader3 gui=bold guifg=#859900
highlight VimwikiHeader4 gui=bold guifg=#b58900
highlight VimwikiHeader5 gui=bold guifg=#d33682
highlight VimwikiHeader6 gui=bold guifg=#dc322f
highlight VimwikiLink gui=bold,underline guifg=#268bd2
highlight VimwikiHeaderChar guifg=#839496

" Lua Configuration
" -----------------
lua << EOF
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
  buf_set_keymap('n', '<LEADER>r', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'K',         '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)

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

nvim_lsp.jedi_language_server.setup{
    on_attach = on_attach,
    capabilities = capabilities
}

nvim_lsp.bashls.setup{
    on_attach = on_attach,
    capabilities = capabilities
}

nvim_lsp.cmake.setup{
    on_attach = on_attach,
    capabilities = capabilities
}

nvim_lsp.openscad_lsp.setup{
    on_attach = on_attach,
    capabilities = capabilities
}

nvim_lsp.ansiblels.setup{
    on_attach = on_attach,
    capabilities = capabilities
}

-- nvim-treesitter
require('orgmode').setup_ts_grammar()
require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = {'org'},
    },
    ensure_installed = {'org', 'yaml'},
}

-- orgmode.nvim
require('orgmode').setup{
    org_agenda_files = {'~/todo/*.org', '~/todo/projects/*.org'},
    org_default_notes_file = '~/todo/notes.org',
    org_hide_leading_stars = true,
    org_agenda_start_on_weekday = 0,
    calendar_week_start_day = 0,
    org_agenda_skip_scheduled_if_done = true,
    org_agenda_skip_deadline_if_done = true,
    org_blank_before_new_entry = {
        heading = false,
        plain_list_item = false,
    },
    mappings = {
        org = {
            org_toggle_checkbox = '<Space>ob'
        },
    },
}

-- org-bullets.nvim
require('org-bullets').setup{
    concealcursor = true,
    symbols = {
        headlines = { "○" },
        checkboxes = {
            half = { "-", "OrgTSCheckboxHalfChecked" },
            todo = { " ", "OrgTODO" },
        }
    },
}

-- nvim-tree.lua
local function nvim_tree_on_attach(bufnr)
    local api = require('nvim-tree.api')
    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open'))
    vim.keymap.set('n', '<C-t>', api.node.open.tab,                 opts('Open: New Tab'))
    vim.keymap.set('n', '<C-v>', api.node.open.vertical,            opts('Open: Vertical Split'))
    vim.keymap.set('n', '<C-s>', api.node.open.horizontal,          opts('Open: Horizontal Split'))
    vim.keymap.set('n', '<C-k>', api.node.show_info_popup,          opts('Info'))
    vim.keymap.set('n', 'r',     api.fs.rename,                     opts('Rename'))
    vim.keymap.set('n', '<CR>',  api.node.open.edit,                opts('Open'))
    vim.keymap.set('n', '<Tab>', api.node.open.preview,             opts('Open Preview'))
    vim.keymap.set('n', 'a',     api.fs.create,                     opts('Create'))
    vim.keymap.set('n', 'd',     api.fs.remove,                     opts('Delete'))
    vim.keymap.set('n', 'c',     api.fs.copy.node,                  opts('Copy'))
    vim.keymap.set('n', 'x',     api.fs.cut,                        opts('Cut'))
    vim.keymap.set('n', 'p',     api.fs.paste,                      opts('Paste'))
    vim.keymap.set('n', 'y',     api.fs.copy.filename,              opts('Copy Name'))
    vim.keymap.set('n', 'Y',     api.fs.copy.relative_path,         opts('Copy Relative Path'))
    vim.keymap.set('n', 'gy',    api.fs.copy.absolute_path,         opts('Copy Absolute Path'))
    vim.keymap.set('n', 'g?',    api.tree.toggle_help,              opts('Help'))
    vim.keymap.set('n', 'R',     api.tree.reload,                   opts('Refresh'))
    vim.keymap.set('n', 'q',     api.tree.close,                    opts('Close'))
    vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,       opts('Open'))
end
require('nvim-tree').setup {
    on_attach = nvim_tree_on_attach,
    renderer = {
        add_trailing = true,
        group_empty = true,
        highlight_git = true,
        highlight_opened_files = "all",
        indent_markers = {
            enable = true,
        },
    },
    filters = {
        dotfiles = true,
        custom = { '.git' }
    },
    git = {
        ignore = true
    },
    actions = {
        open_file = {
            quit_on_open = true
        }
    }
}

-- gitsigns.nvim
require('gitsigns').setup{
    signs = {
        add          = {hl = 'GitSignsAdd',       text = '│',  numhl='GitSignsAddNr'   ,    linehl='GitSignsAddLn'},
        change       = {hl = 'GitSignsChange',    text = '│',  numhl='GitSignsChangeNr',    linehl='GitSignsChangeLn'},
        delete       = {hl = 'GitSignsDelete',    text = '_',  numhl='GitSignsDeleteNr',    linehl='GitSignsDeleteLn'},
        topdelete    = {hl = 'GitSignsDelete',    text = '‾',  numhl='GitSignsDeleteNr',    linehl='GitSignsDeleteLn'},
        changedelete = {hl = 'GitSignsChange',    text = '│_', numhl='GitSignsChangeNr',    linehl='GitSignsChangeLn'},
        untracked    = {hl = 'GitSignsUntracked', text = '│',  numhl='GitSignsUntrackedNr', linehl='GitSignsUntrackedLn'},
    },
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        map('n', '<LEADER>j', gs.next_hunk)
        map('n', '<LEADER>k', gs.prev_hunk)
        map('n', '<LEADER>gs', gs.stage_hunk)
        map('v', '<LEADER>gs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('n', '<LEADER>gu', gs.undo_stage_hunk)
        map('n', '<LEADER>gr', gs.reset_hunk)
        map('v', '<LEADER>gr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('n', '<LEADER>gR', gs.reset_buffer)
        map('n', '<LEADER>gp', gs.preview_hunk)
        map('n', '<LEADER>gb', function() gs.blame_line{full=true} end)

        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
}

-- nvim-toggleterm.lua
require('toggleterm').setup{
    size = 20,
    open_mapping = [[<C-t>]],
    hide_numbers = true,
    shade_terminals = false,
    start_in_insert = true,
    insert_mappings = false,
    persist_size = true,
    direction = 'horizontal',
    close_on_exit = true,
    float_opts = {
        border = 'curved',
    }
}

local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
    cmd = 'lazygit',
    direction = 'float',
    close_on_exit = true,
    hidden = true
})

function _lazygit_toggle()
    lazygit:toggle()
end

local python = Terminal:new({
    cmd = 'python',
    direction = 'horizontal',
    close_on_exit = true,
    hidden = true
})

function _python_toggle()
    python:toggle()
end
EOF
