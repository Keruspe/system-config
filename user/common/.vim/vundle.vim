set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'lifepillar/vim-mucomplete'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/gnupg.vim'
Plugin 'rust-lang/rust.vim'
call vundle#end()
filetype plugin indent on

" vundle
let g:vundle_default_git_proto='git'

" Command-T
noremap <leader>e :CommandTFlush<cr>\|:CommandT<cr>
noremap <leader>r :CommandTFlush<cr>\|:CommandTBuffer<cr>
