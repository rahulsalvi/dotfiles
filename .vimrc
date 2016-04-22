set backspace=indent,eol,start
set nobackup
set nowritebackup
set noswapfile
set number
set nowrap
set splitbelow
set splitright
set cursorline
set tabstop=4
set shiftwidth=4
set expandtab
set mouse=a

aug CursorLine
    autocmd!
    autocmd VimEnter * setl cursorline
    autocmd WinEnter * setl cursorline
    autocmd BufWinEnter * setl cursorline
    autocmd WinLeave * setl nocursorline
aug END

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'https://github.com/rking/ag.vim.git'
Plug 'https://github.com/bronson/vim-trailing-whitespace.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/altercation/vim-colors-solarized.git'
Plug 'https://github.com/junegunn/vim-easy-align.git'
Plug 'https://github.com/Shougo/unite.vim.git'
Plug 'https://github.com/Shougo/vimproc.vim.git', { 'do': 'make' }
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
Plug 'https://github.com/mrtazz/DoxygenToolkit.vim.git', { 'on': 'Dox' }
Plug 'https://github.com/Valloric/YouCompleteMe.git', { 'do': './install.py --clang-completer' }
Plug 'https://github.com/Raimondi/delimitMate.git'
Plug 'https://github.com/christoomey/vim-tmux-navigator.git'
Plug 'https://github.com/tpope/vim-dispatch.git'
Plug 'https://github.com/tpope/vim-obsession.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/wellle/targets.vim.git'
Plug 'https://github.com/vim-scripts/YankRing.vim.git'
Plug 'https://github.com/Valloric/ListToggle.git'
Plug 'https://github.com/tpope/vim-unimpaired.git'
Plug 'https://github.com/tpope/vim-repeat.git'

call plug#end()

" Plugin Configurations

" Ag
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts =
                \ '-i --vimgrep --hidden --ignore ' .
                \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    let g:unite_source_grep_recursive_opt = ''
endif

" Colorscheme
if $BACKGROUND == "light"
    set background=light
else
    set background=dark
endif
let g:solarized_termtrans=1
let g:solarized_termcolors=256
try
    colorscheme solarized
catch
endtry

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Unite
nnoremap gu :Unite file/async <Enter>
call unite#custom#source('file,file/async', 'matchers', ['converter_relative_word', 'matcher_project_ignore_files', 'matcher_default'])
call unite#custom#source('file,file/async', 'matchers', ['converter_relative_abbr', 'matcher_project_ignore_files', 'matcher_default'])
call unite#custom#source('file_rec,file_rec/async', 'matchers', ['converter_relative_word', 'matcher_project_ignore_files', 'matcher_default'])
call unite#custom#source('file_rec,file_rec/async', 'matchers', ['converter_relative_abbr', 'matcher_project_ignore_files', 'matcher_default'])

" Airline
let g:airline_theme='solarized'
let g:airline_powerline_fonts=1
let g:airline#extensions#ycm#enabled=1
let g:airline#extensions#ycm#error_symbol='E:'
let g:airline#extensions#ycm#warning_symbol='W:'
if &background == 'dark'
    let g:airline_solarized_bg='dark'
else
    let g:airline_solarized_bg='light'
endif
set ttimeoutlen=50
set laststatus=2

" YouCompleteMe
let g:ycm_global_ycm_extra_conf = "~/.ycm_extra_conf.py"
let g:ycm_error_symbol='E>'
let g:ycm_warning_symbol='W>'
let g:ycm_always_populate_location_list=1
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_max_diagnostics_to_display=1000

" YankRing
let g:yankring_history_dir='~/.vim'

" ListToggle
let g:lt_location_list_toggle_map = 'gl'
let g:lt_quickfix_list_toggle_map = 'gk'
