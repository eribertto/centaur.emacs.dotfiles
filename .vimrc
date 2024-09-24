" new vimrc in Alpine distrobox and Fedora 40
" Wed Jul 24, 2024 13:44

if empty(glob('~/.vim/autoload/plug.vim'))
	  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'thaerkh/vim-workspace'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'SirVer/ultisnips'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
Plug 'davidhalter/jedi-vim'
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'christoomey/vim-tmux-navigator'
" vim-plug support for writing nix-expressions
Plug 'LnL7/vim-nix'
Plug 'tpope/vim-commentary'
" https://github.com/kana/vim-textobj-entire?tab=readme-ov-file
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-user'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
call plug#end()

""""""""""""""""""""""
"      Settings      "
""""""""""""""""""""""
" Enables us Vim specific features
set nocompatible                

let g:lightline = {'colorscheme': 'catppuccin_mocha'}
" indentations"
set tabstop=4
set expandtab
set shiftwidth=4
set shiftround

filetype off                    " Reset filetype detection first ...
filetype plugin indent on       " ... and enable filetype detection
set ttyfast                     " Indicate fast terminal conn for faster redraw
set ttymouse=xterm2             " Indicate terminal type for mouse codes
set ttyscroll=3                 " Speedup scrolling
set laststatus=2                " Show status line always
set encoding=utf-8              " Set default encoding to UTF-8
set autoread                    " Automatically read changed files
set autoindent                  " Enabile Autoindent
set backspace=indent,eol,start  " Makes backspace key more powerful.
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set noerrorbells                " No beeps
set number                      " Show line numbers
set showcmd                     " Show me what I'm typing
set noswapfile                  " Don't use swapfile
set nobackup                    " Don't create annoying backup files
set splitright                  " Vertical windows should be split to right
set splitbelow                  " Horizontal windows should split to bottom
set noautowrite                   " Automatically save before :next, :make etc.
set hidden                      " Buffer should still exist if window is closed
set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats
set noshowmatch                 " Do not show matching brackets by flickering
set noshowmode                  " We show the mode with airline or lightline
set ignorecase                  " Search case insensitive...
set infercase			" for autocompletion and case sensitivity
set smartcase                   " ... but not it begins with upper case
set completeopt=menu,menuone    " Show popup menu, even if there is one entry
set pumheight=10                " Completion window max size
set nocursorcolumn              " Do not highlight column (speeds up highlighting)
set nocursorline                " Do not highlight cursor (speeds up highlighting)
set lazyredraw                  " Wait to redraw
set laststatus=2
set termguicolors               " turn on true colors in terminal vim
set readonly			" protect this vimrc from accidental edits
set nrformats=			" treat all numerals as decimal regardless if zero padded or not




" Enable to copy to clipboard for operations like yank, delete, change and put
" http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
if has('unnamedplus')
  set clipboard+=unnamed
  set clipboard+=unnamedplus
endif

" Mon 07 Oct 2019 10:06:43 PM +03
inoremap <F6> <C-R>=strftime("%a %b %d, %Y %H:%M")<CR><Esc>0i# <Esc>
nnoremap <F6> "=strftime("%c")<CR>P0i
map <F3> :!clear;perl %<CR>
map <F4> :!clear;perltidy %<CR>

"turn off search highlight
map <F8> :nohlsearch<CR>


" This enables us to undo files even if you exit Vim.
if has('persistent_undo')
  set undofile
  set undodir=~/.config/vim/tmp/undo//
endif

" Colorscheme
syntax enable
set t_Co=256
let g:rehash256 = 1
let g:molokai_original = 1
" colorscheme elflord
" let g:lightline = {'colorscheme': 'catppuccin_mocha'}
let g:airline_theme = 'catppuccin_mocha'

""""""""""""""""""""""
"      Mappings      "
""""""""""""""""""""""

"Set leader shortcut 
let mapleader="\<Space>"
nnoremap <leader>m :silent make\|redraw!\|cw<CR>
imap jk <Esc>
" save current buffer
nnoremap <leader>w :w<cr>

" Go to tab by numbers
" https://superuser.com/questions/410982/in-vim-how-can-i-quickly-switch-between-tabs
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>


" autoclose tags
" "https://aonemd.github.io/blog/handy-keymaps-in-vim
inoremap ( ()<Left>
inoremap { {}<Left>
inoremap [ []<Left>
inoremap " ""<Left>
"move lines around
nnoremap <leader>k :m-2<cr>==
nnoremap <leader>j :m+<cr>==
xnoremap <leader>k :m-2<cr>gv=gv
xnoremap <leader>j :m'>+<cr>gv=gv

" Jump to next error with Ctrl-n and previous error with Ctrl-m. Close the
" quickfix window with <leader>a
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" Visual linewise up and down by default (and use gj gk to go quicker)
noremap <Up> gk
noremap <Down> gj
noremap j gj
noremap k gk
nnoremap gV `[v`]
"map jk as escape in insert mode
"note vsp will split window vertical
"july 17, 2018 more related to splits
set splitbelow
set splitright
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Act like D and C
nnoremap Y y$

" Enter automatically into the files directory
autocmd BufEnter * silent! lcd %:p:h
" autosave mode off
" autocmd TextChanged,TextChangedI <buffer> silent write

"""""""""""""""""""""
"      Plugins      "
"""""""""""""""""""""
"# Sat Feb 25, 2023 14:25

" python development
au BufNewFile,BufRead *.py setfiletype python
au Filetype python set tabstop=4 shiftwidth=4 encoding=utf-8 softtabstop=4 textwidth=79 fileformat=unix expandtab autoindent  

" powerline.vim
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

" lsp "
" https://github.com/prabirshrestha/vim-lsp
if executable('pylsp')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END



set laststatus=2
