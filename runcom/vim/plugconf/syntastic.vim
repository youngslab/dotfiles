
" ----------------------
" SyntasticCheck Configuration
" ----------------------
"
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_cpp_checkers=["clang_check", "clang_tidy"]
let g:syntastic_cpp_clang_tidy_post_args=""
let g:syntastic_cpp_clang_tidy_args="-checks='*' -fix-errors"
let g:syntastic_cpp_clang_check_post_args=""
let g:syntastic_cpp_clang_check_args="-fixit"
let g:syntastic_cpp_check_header = 1 "belongs to gcc checker.

let g:syntastic_c_checkers=["clang_check", "clang_tidy"]
let g:syntastic_c_clang_tidy_post_args=""
let g:syntastic_c_clang_check_post_args=""
let g:syntastic_c_clang_tidy_args="'-checks=*'"

" for debuggings.
" let syntastic_debug = 1 " using >:mes to check the logs.
let g:syntastic_mode_map = { 'mode': 'passive',
            \ 'active_filetypes': [],
            \ 'passive_filetypes': [] }

let g:syntastic_always_populate_loc_list = 1 
let g:syntastic_auto_loc_list = 1 
let g:syntastic_check_on_open = 0 
let g:syntastic_check_on_wq = 1 

nnoremap <leader>s :let b:syntastic_cpp_clang_tidy_args="-fix-errors"<CR> :let b:syntastic_mode="active" <CR>
nnoremap <leader>ss :let b:syntastic_cpp_clang_tidy_args="'-checks=*' -fix-errors"<CR> :let b:syntastic_mode="active"<CR>
nnoremap <leader>sss :let b:syntastic_mode="passive"<CR>
"nmap \cc :SyntasticCheck<CR>
"let g:syntastic_c_clang_tidy_args="'-checks=*'"
