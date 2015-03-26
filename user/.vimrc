" Begin vundle conf
set nocompatible
filetype off
let g:vundle_default_git_proto='git'
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'
call vundle#end()
filetype plugin indent on
" End vundle conf

set background=dark
set backspace=indent,eol,start
set et sts=4 sw=4
set hidden
set history=500
set hlsearch
set incsearch
set nomodeline
set ruler
set showcmd
set showmatch
set t_Co=256
set termencoding=utf-8
set tw=120
set viminfo='1000,f1,:1000,/1000
set title
set mouse=a

let g:full_name = 'Marc-Antoine Perennou'
let g:full_identity = 'Marc-Antoine Perennou <Marc-Antoine@Perennou.com>'
let g:exheres_author_name = 'Marc-Antoine Perennou <keruspe@exherbo.org>'
let g:netrw_http_cmd = "curl -o"

syntax on
