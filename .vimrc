syntax on
filetype plugin indent on
set ignorecase
set smartcase
set exrc
set secure
set bg=dark
match Todo /\s\+$/

set directory^=$HOME/.vim_swap//

autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala            setfiletype vala
au BufRead,BufNewFile *.vapi            setfiletype vala

" go to opening/closing brace, and type %= to indent everything in between
noremap % v%

function Gofmt()
	let regel=line(".")
	%!gofmt
	call cursor(regel, 1)
endfunction
autocmd Filetype go command! Fmt call Gofmt()
autocmd BufWritePre *.go call Gofmt()
