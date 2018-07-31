set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'ciaranm/securemodelines'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/Command-T'
Plugin 'vim-scripts/gnupg.vim'
Plugin 'vim-scripts/gtk-vim-syntax'
Plugin 'rust-lang/rust.vim'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
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

" vim-lsp
au User lsp_setup call lsp#register_server({ 'name': 'rls', 'cmd': {server_info->['rls']}, 'whitelist': ['rust'] })

" asyncomplete
let g:asyncomplete_remove_duplicates = 1
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
