" set colors
set term=xterm-256color

if has('termguicolors')
    set termguicolors
endif

if !has('gui_running')
  set t_Co=256
endif

set background=dark

" vim-plug
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'ctrlpvim/ctrlp.vim', {'on': ['CtrlP', 'CtrlPMixed', 'CtrlPMRU']}
Plug 'phanviet/vim-monokai-pro'
Plug 'artanikin/vim-synthwave84'
Plug 'ntk148v/vim-horizon'
Plug 'prabirshrestha/async.vim'
Plug 'itchyny/lightline.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'rust-lang/rust.vim'
Plug 'sheerun/vim-polyglot'
call plug#end()

" Always show statusline
set laststatus=2
" Hide original statusline
"set noshowmode
" enable line numbers
set nu

" auto install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set nocompatible

" rust
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif

" set colorscheme
colorscheme horizon
" lightline
let g:lightline = {}
let g:lightline.colorscheme = 'horizon'

