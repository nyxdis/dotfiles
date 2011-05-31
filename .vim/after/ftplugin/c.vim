set cindent
set tw=79
set fo+=t

augroup vimrc_autocmds
	autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
	autocmd BufEnter * match OverLength /\%79v.*/
augroup END
