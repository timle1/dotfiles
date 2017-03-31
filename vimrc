" For https://github.com/junegunn/vim-plug
" manual install
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" :PlugInstall to install plugins

" Automatic
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')


" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plug 'tmhedberg/SimpylFold'
"Plugin 'vim-scripts/indentpython.vim'
Plug 'w0rp/ale'
Plug 'python-mode/python-mode'
Plug 'Valloric/YouCompleteMe'
Plug 'jnurmine/Zenburn'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-fugitive'
Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
"Plug 'google/yapf'
Plug 'vimwiki/vimwiki'
  Plug 'suan/vim-instant-markdown'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
Plug 'terryma/vim-expand-region'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'


" Initialize plugin system
call plug#end()
" on startup run :PlugInstall

let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'molokai'
"let g:airline_theme = 'onedark'
let g:airline_detect_modified = 1
let g:airline_detect_paste = 1
" set background=dark

" From https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
" Set leader key to space instead of \
let mapleader = "\<Space>"
" Type <Space>o to open a new file:
nnoremap <Leader>o :CtrlP<CR>
" Type <Space>w to save file (a lot faster than :w<Enter>):
nnoremap <Leader>w :w<CR>
" Copy & paste to system clipboard with <Space>p and <Space>y:
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
" Enter visual line mode with <Space><Space>:
nmap <Leader><Leader> V

" Expand and shrink region via terryma/vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

"search gn http://vimcasts.org/episodes/operating-on-search-matches-using-gn/

" Automatically jump to end of text you pasted:
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" Quickly select text you just pasted:
noremap gV `[v`]
" Stop that stupid window from popping up:
map q: :q


" from https://www.fullstackpython.com/vim.html
"
" enable syntax highlighting
syntax enable

" show line numbers
set number

" show a visual line under the cursor's current line
set cursorline

" show the matching part of the pair for [] {} and ()
set showmatch


" from https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/#vim-extensions
"
"split :sp and :vs, navigations ^hjkl, use tmux instead 
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za
let g:SimpylFold_docstring_preview=1

"au BufNewFile,BufRead *.js, *.html, *.css
"    \ set tabstop=2
"    \ set softtabstop=2
"    \ set shiftwidth=2
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set encoding=utf-8

"YCM completion window
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

let g:pymode_python = 'python3'

let python_highlight_all=1
syntax on
if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif
"switch between light and dark solarized theme with F5
call togglebg#map("<F5>")

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

"show line numbers
set nu
"use X11 clipboard instead of vim buffer
set clipboard=unnamed

"google/yapf format your python code via <LocalLeader> =.
"autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>

" vimwiki - Personal Wiki for Vim
" https://github.com/vimwiki/vimwiki
set nocompatible
filetype plugin on
syntax on
" vimwiki with markdown support
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
" helppage -> :h vimwiki-syntax 

" vim-instant-markdown - Instant Markdown previews from Vim
" https://github.com/suan/vim-instant-markdown
let g:instant_markdown_autostart = 0	" disable autostart
map <leader>md :InstantMarkdownPreview<CR>
