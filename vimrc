" For https://github.com/junegunn/vim-plug
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Commands :PlugInstall :PlugUpdate PlugUpgrade PlugClean

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
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
"Plug 'google/yapf'
Plug 'jnurmine/Zenburn'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"  Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-fugitive'
Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
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


let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'molokai'
"let g:airline_theme = 'powerlineish'
let g:airline_detect_modified = 1
let g:airline_detect_paste = 1
" set background=dark


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

set encoding=utf-8
set splitbelow
set splitright


" From https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
" Set leader key to space instead of \
let mapleader = "\<Space>"
" Type <Space>n to create a new file:
nnoremap <Leader>n :e %:h/

" Type <Space>w to save file (a lot faster than :w<Enter>):
nnoremap <Leader>w :w<CR>

" Enter visual line mode with <Space><Space>:
nmap <Leader><Leader> V

nmap <Leader>q :q<CR>

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
noremap <Leader>v `[v`]
" Stop that stupid window from popping up:
map q: :q

" FZF bindings
" let g:fzf_command_prefix = 'Fzf'
" buffers are currently opened files
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>c :Commands<CR>
" find text in open"ed files"
nnoremap <Leader>f :BLines<CR>
"
"imap <c-x><c-k> <plug>(fzf-complete-word)
"imap <c-x><c-l> <plug>(fzf-complete-line)
"imap <c-x><c-f> <plug>(fzf-complete-file)
"imap <c-x><c-p> <plug>(fzf-complete-path)

fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GitFiles
  endif
endfun
nnoremap <C-p> :call FzfOmniFiles()<CR>


" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <Leader>[ za
let g:SimpylFold_docstring_preview=1


let g:pymode_python = 'python3'
let python_highlight_all=1


let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
"auto open a NERDTree if no files were specified
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"close vim if the only window left open is a NERDTree
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

map <C-b> :NERDTreeToggle<CR>


"use X11 clipboard instead of vim buffer
set clipboard=unnamedplus
"http://vi.stackexchange.com/questions/84/how-can-i-copy-text-to-the-system-clipboard-from-vim
" Copy & paste to system clipboard with <Space>p and <Space>y:
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P


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
