
" ----------------------
" TERMINAL Configuration
" ----------------------
" auto commands
au ExitPre * call Term_Exit()
au TerminalOpen * if &buftype == 'terminal' | setlocal bufhidden=hide nobuflisted | endif
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
au BufDelete * if &buftype == 'terminal' | echom "BufDelete" | endif
au BufUnload * if &buftype == 'terminal' | echom "BufUnload" | endif


" toggle keymap
nnoremap <C-G> :call Term_toggle(10)<CR>
tnoremap <C-G> <C-W>:call Term_toggle(10)<CR>

" toggling function
let g:term_buf = 0
let g:term_win = 0
function! Term_toggle(height)
	 if win_gotoid(g:term_win)
			 hide
	 else
			 botright new
			 exec "resize " . a:height
			 try
					 exec "buffer " . g:term_buf
			 catch
					 " call termopen($SHELL, {"detach": 0})
					 exe "term++curwin"
					 let g:term_buf = bufnr("")
			 endtry
			 echom "terminal buf : " g:term_buf
			 startinsert!
			 let g:term_win = win_getid()
	 endif
endfunction

function! Term_Exit()
	echom "try to delete: buffer nr: " g:term_buf
	exec "bdelete! " g:term_buf
endfunction

" Workaround: terminal background color issue
" when solarized theme, background color is wired
hi Terminal ctermbg=0

"(l)ines:
nnoremap <leader>l  :BLines <CR>
"(c)ommits
nnoremap <leader>c  :Commits <CR>
"(b)uffers:
nnoremap <leader>b  :Buffers <CR>
"(t)files
nnoremap <leader>t  :Files<CR>
"(s)ymobls
nnoremap <leader>s  :Tags <CR>

" Termdebug
let g:termdebug_popup = 0
let g:termdebug_wide = 163

