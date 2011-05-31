filetype plugin indent on
set ignorecase
set smartcase
set exrc
set secure
set bg=dark
match Todo /\s\+$/

set directory^=$HOME/.vim_swap//

augroup vimrc_autocmds
	autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
	autocmd BufEnter * match OverLength /\%74v.*/
augroup END
