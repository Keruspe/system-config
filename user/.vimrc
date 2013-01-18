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

let g:exheres_author_name = 'Marc-Antoine Perennou <Marc-Antoine@Perennou.com>'
let g:full_name = 'Marc-Antoine Perennou'
let g:full_identity = 'Marc-Antoine Perennou <Marc-Antoine@Perennou.com>'
let g:secure_modelines_verbose = 0
let g:secure_modelines_modelines = 15

if has("eval")
    filetype on
    filetype plugin on
    filetype indent on
    if has ('autocmd')
        augroup fromgentoo
            autocmd!
            autocmd BufReadPost *
                  \ if ! exists("g:leave_my_cursor_position_alone") |
                  \     if line("'\"") > 0 && line ("'\"") <= line("$") |
                  \         exe "normal g'\"" |
                  \     endif |
                  \ endif
        augroup END
        function! MakeGenericCopyrightHeader()
            0 put ='# Copyright '.strftime('%Y').' '.g:full_identity
            put ='# Distributed under the terms of the GNU General Public License v2'
            $
        endfun
        fun! UpdateCopyrightHeaders()
            let l:a = 0
            for l:x in getline(1, 10)
                let l:a = l:a + 1
                if -1 != match(l:x, 'Copyright \((c) \)\?[- 0-9,]*20\(0[456789]\|1[012]\) Marc-Antoine Perennou')
                    if input("Update copyright header? (y/N) ") == "y"
                        call setline(l:a, substitute(l:x, '\(20\(0[456789]\|1[012]\)\) Marc-Antoine',
                                    \ '\1, 2013 Marc-Antoine', ""))
                    endif
                endif
            endfor
        endfun
        augroup keruspe
            autocmd!
            autocmd BufReadPost **.git/COMMIT_EDITMSG exe "normal gg"
            autocmd BufNewFile,BufRead /etc/dbus-1/**/*.conf setl ft=xml
            autocmd BufNewFile *.exheres-* call MakeGenericCopyrightHeader()
            autocmd BufWritePre * call UpdateCopyrightHeaders()
            autocmd BufNewFile,BufRead /{etc,lib*}/systemd/**.{conf,target,service,socket,mount,automount,swap,path,timer,snapshot,device} setl ft=desktop
            autocmd BufNewFile,BufRead **/.claws-mail/tmp/tmpmsg.* setl ft=mail
        augroup END
    endif
endif

if has('mouse')
    set mouse=a
endif

if has("syntax")
    syntax on
endif

if has('title')
    set title
endif

if executable("curl")
    let g:netrw_http_cmd = "curl -o"
elseif executable("wget")
    let g:netrw_http_cmd = "wget -q -O"
elseif executable("fetch")
    let g:netrw_http_cmd = "fetch -o"
else
    let g:netrw_http_cmd = ""
endif
