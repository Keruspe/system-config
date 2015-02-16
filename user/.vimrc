set background=dark
set backspace=indent,eol,start
set et sts=4 sw=4
set history=500
set hlsearch
set incsearch
set nocompatible
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

filetype on
filetype plugin on
filetype indent on

au FileType javascript setl sw=2 sts=2

augroup keruspe
    autocmd!
    autocmd BufReadPost **.git/COMMIT_EDITMSG exe "normal gg"
    autocmd BufNewFile,BufRead /etc/dbus-1/**/*.conf setl ft=xml
    autocmd BufNewFile,BufRead /{etc,lib*}/systemd/**.{conf,target,service,socket,mount,automount,swap,path,timer,snapshot,device} setl ft=desktop
augroup END

syntax on
