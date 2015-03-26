set nocompatible
filetype off
let g:vundle_default_git_proto='git'
let g:airline#extensions#tabline#enabled = 1
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/gnupg.vim'
call vundle#end()
filetype plugin indent on
