syntax on
filetype plugin indent on
set ignorecase
set smartcase
set exrc
set secure
set bg=dark
set hlsearch
set laststatus=2
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
match Todo /\s\+$/

set directory^=$HOME/.vim_swap//

autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala            setfiletype vala
au BufRead,BufNewFile *.vapi            setfiletype vala

" go to opening/closing brace, and type %= to indent everything in between
noremap % v%

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
