set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/Command-T'
Plugin 'vim-scripts/gnupg.vim'
Plugin 'rust-lang/rust.vim'
call vundle#end()
filetype plugin indent on

" vundle
let g:vundle_default_git_proto='git'

" vim-airline
let g:airline#extensions#tabline#enabled = 1
set laststatus=2

" Command-T
noremap <leader>e :CommandTFlush<cr>\|:CommandT<cr>
noremap <leader>r :CommandTFlush<cr>\|:CommandTBuffer<cr>