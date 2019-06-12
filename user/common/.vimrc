source ~/.vim/vundle.vim

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

let g:full_name = 'Marc-Antoine Perennou'
let g:full_identity = 'Marc-Antoine Perennou <Marc-Antoine@Perennou.com>'
let g:exheres_author_name = 'Marc-Antoine Perennou <keruspe@exherbo.org>'
let g:netrw_http_cmd = "curl -o"

syntax on

function! s:get_lsp_server_cmd_for_rust()
    return ['rls']
endfunction

" vim-airline
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
