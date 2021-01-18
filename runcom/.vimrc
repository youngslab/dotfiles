if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" For Mac/Linux users
call plug#begin('~/.vim/bundle')
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic', {'for': 'cpp'}

" key binding 
Plug 'tpope/vim-unimpaired'

Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' , 'for': 'cpp'}
Plug 'derekwyatt/vim-fswitch'

" auto-completion
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Test
Plug 'alepez/vim-gtest', {'for': 'cpp'}
Plug 'tpope/vim-fugitive'

Plug 'djoshea/vim-autoread'
Plug 'tmhedberg/SimpylFold'
"Plug 'sirver/ultisnips'
Plug 'milkypostman/vim-togglelist'

" infra
Plug 'will133/vim-dirdiff'

" build
Plug 'tpope/vim-dispatch'

" THEMES
Plug 'junegunn/goyo.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'

" TAGS
Plug 'brookhong/cscope.vim'
Plug 'craigemery/vim-autotag'

""""""""""""""""""""""""""""""
""""""""" languages """""""""
""""""""""""""""""""""""""""""
" LANGUAGE - cpp
Plug 'rhysd/vim-clang-format', {'for': 'cpp'}
Plug 'vim-scripts/DoxygenToolkit.vim', {'for': 'cpp'}
Plug 'octol/vim-cpp-enhanced-highlight'   , {'for': 'cpp'}

" LANGUAGE - Markdown
Plug 'plasticboy/vim-markdown'

" LANGUAGE - CMake
Plug 'pboettch/vim-cmake-syntax'

" Haskell
Plug 'eagletmt/ghcmod-vim' , {'for': 'haskell'}
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'eagletmt/neco-ghc', {'for': 'haskell'}
Plug 'neovimhaskell/haskell-vim' , {'for': 'haskell'}
Plug 'alx741/vim-hindent', {'for': 'haskell'}

" Python 
Plug 'klen/python-mode' , {'for': 'python', 'branch': 'develop'} 
Plug 'scrooloose/syntastic', {'for': 'python'}

" ctags and cscope "
Plug 'brookhong/cscope.vim' " , {'for':  ['c', 'cpp'] }

call plug#end()

" Setup g:os for current Operating System.
if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

" set term=screen-256color  " support 256 color in term
set term=xterm-256color  " support 256 color in term
syntax on
filetype plugin indent on
set t_Co=256
set t_ut=
set incsearch " search as characters are entered
set hlsearch " highlight matches
set backspace=indent,eol,start
set textwidth=80
set encoding=utf-8

" Hybrid line number ( relative + absolute)
:set number relativenumber
:set nu rnu

" indent config.
" set autoindent
set cindent
set smartindent
" set expandtab " tab to space
set tabstop=2 
set shiftwidth=2

" Hybrid line number ( relative + absolute)
set number relativenumber
set nu rnu

" clipboard


if g:os == "Darwin"
  set clipboard=unnamed " use OS clipboard
elseif g:os == "Linux"
  set clipboard=unnamedplus " use OS clipboard
endif

" themes
set background=dark
colorscheme solarized

" plugin - airline
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1 " for buffers
let g:airline_powerline_fonts = 1            " symbols
set laststatus=2                             " need to show the power line.

" plugin - syntax
let g:cpp_class_scope_highlight = 1

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1

" menu autocompletion
set wildmenu
set wildmode=longest:full,full " Display Vim command mode autocompletion list

" let g:ycm_min_num_of_chars_for_completion=99

" key maps.
let mapleader = ","

inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
inoremap <C-b> <C-o>h
inoremap <C-f> <C-o>l

" move vertically by visual line 
nnoremap j gj
nnoremap k gk

" --------------------------------------------------
" configure - build 
"set makeprg=cmake\ --build\ ./build

nnoremap <F5> :Make<CR>
" -- gererate 
nnoremap <F6> :Dispatch cmake -B./nbuild -H. -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_BUILD_TYPE=Debug<CR>
" -- generate compilation
nnoremap <F7> :Dispatch cmake -B./mbuild -H. -DCMAKE_EXPORT_COMPILE_COMMANDS=1 <CR>

" --------------------------------------------------
" configure - nerd tree 
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" --------------------------------------------------
" configure - fold 
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf



nnoremap <silent> \h :noh<CR>                     " close highlight


" --------------------------------------------------
" configure - utilities
nmap \n :setlocal number! relativenumber!<CR>

nmap \o :set paste!<CR>
nmap \cw <C-W>q " close buffer
nmap \t :YcmCompleter GetType<CR> 
nmap \r :e!<CR> " reload w/o saving
nmap \s :w<CR>

nmap <script> <silent> \l :call ToggleLocationList()<CR>
nmap <script> <silent> \q :call ToggleQuickfixList()<CR>


" --------------------------------------------------
" configure - clang format
let g:clang_format#auto_format = 0
let g:clang_format#style_options = { 
    \ "IndentWidth" : 2, 
    \ "SortIncludes" : "false",
    \ "Standard" : "C++11" }
" let g:clang_format#detect_style_file = 1
let g:clang_format#code_style = "llvm"

" key map 
autocmd FileType h, hpp, c, cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType h, hpp, c, cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

" --------------------------------------------------
" configure - syntastatic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_cpp_checkers=["clang_check", "clang_tidy"]
let g:syntastic_cpp_clang_tidy_post_args=""
" let g:syntastic_cpp_clang_tidy_args="-checks='*' -fix-errors -p ./mbuild"
let g:syntastic_cpp_clang_check_post_args=""
let g:syntastic_cpp_clang_check_args="-p ./mbuild -fixit"
let g:syntastic_cpp_check_header = 1 "belongs to gcc checker.

let g:syntastic_c_checkers=["clang_check", "clang_tidy"]
let g:syntastic_c_clang_tidy_post_args=""
let g:syntastic_cpp_clang_check_post_args=""
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

nnoremap <leader>s :let b:syntastic_cpp_clang_tidy_args="-fix-errors -p ./mbuild"<CR> :let b:syntastic_mode="active" <CR>
nnoremap <leader>ss :let b:syntastic_cpp_clang_tidy_args="'-checks=*' -fix-errors -p ./mbuild"<CR> :let b:syntastic_mode="active"<CR>
nnoremap <leader>sss :let b:syntastic_mode="passive"<CR>
"nmap \cc :SyntasticCheck<CR>
"let g:syntastic_c_clang_tidy_args="'-checks=*'"

" --------------------------------------------------
" configure - ycm 
let g:ycm_confirm_extra_conf = 0 
let g:ycm_goto_buffer_command = 'vertical-split'
let g:ycm_show_diagnostics_ui = 0
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>

nnoremap <silent> <F11> :YcmCompleter GoToDeclaration<CR>        
inoremap <silent> <F11> <esc> :YcmCompleter GoToDeclaration<CR>
nnoremap <silent> <F12> :YcmCompleter GoToDefinitionElseDeclaration<CR>        
inoremap <silent> <F12> <esc> :YcmCompleter GoToDefinitionElseDeclaration<CR>

" -------------------------------------------------
"  configure - fstab
nnoremap <leader>o :FSHere<CR>
let g:fsnonewfiles = 'on'

" -------------------------------------------------
"  configure - fzf
nnoremap <leader>t  :FZF -i<CR> " case insensitive
nnoremap <leader>b  :Buffers<CR>
nnoremap <leader>a  :Ag<CR>

" -------------------------------------------------
"  configure - doxygen
let g:DoxygenToolkit_authorName="Jaeyoung Park"
let g:DoxygenToolkit_licenseTag="My own license"

" -------------------------------------------------
"  configure - goyo
"function! ProseMode()
  "call goyo#execute(0, [])
  "set spell noci nosi noai nolist noshowmode noshowcmd
  "set complete+=s
  "set bg=light
  "if !has('gui_running')
    "let g:solarized_termcolors=256
  "endif
  "colors solarized
"endfunction


"command! ProseMode call ProseMode()
"nmap \p :ProseMode<CR>

function! s:goyo_enter()
  set bg=light
  "if !has('gui_running')
    "let g:solarized_termcolors=256
  "endif
  colors solarized
endfunction

function! s:goyo_leave()
  set bg=dark
  "if !has('gui_running')
    "let g:solarized_termcolors=256
  "endif
  colors solarized
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


nmap ,p :Goyo<CR>

" -------------------------------------------------
"  configure - GTest
nnoremap <F9> :GTestRunUnderCursor<CR>
inoremap <F9> <esc> :GTestRunUnderCursor<CR>
nnoremap <F10> :GTestRun<CR>
inoremap <F10> <esc> :GTestRun<CR>


" --------------------------------------------------
" configure - (b)uffers
nnoremap <silent> \b :bp<bar>sp<bar>bn<bar>bd<CR> " [close]

" --------------------------------------------------
" configure - (p)review
nnoremap <silent> \p :pclose <CR> " [close]


" --------------------------------------------------
" configure - (w)indows
set splitbelow
set splitright

nnoremap <silent> + :exe "resize +5" <CR>
nnoremap <silent> - :exe "resize -5" <CR>
nnoremap <silent> > :exe "vertical resize +5" <CR>
nnoremap <silent> < :exe "vertical resize -5" <CR>


nmap \1 1<C-W><C-W>
nmap \2 2<C-W><C-W>
nmap \3 3<C-W><C-W>
nmap \4 4<C-W><C-W>

nnoremap <silent> \w :q <CR>  " [close]
nnoremap <silent> [w <C-W>h   " [next]
nnoremap <silent> ]w <C-W>l   " [prev]

" configure - (q)uick
nnoremap <silent> \q :cclose <CR> 

" configure - (e)tc - quick, loc, preview..
nnoremap <silent> \e :cclose <CR> :lclose<CR> :pclose <CR>

nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
" s: Find this C symbol
nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>

" --------------------------------------------------
" List Mode
" show hidden characters in Vim
:set list

" settings for hidden chars (or set lcs=.....)
:set listchars=tab:▒░,trail:▓,nbsp:░
" set listchars=eol:⏎,tab:␉·,trail:␠,nbsp:⎵

" --------------------------------------------------


" pane movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" insert mode cursor movment
inoremap <C-J> <Down>
inoremap <C-K> <Up>
inoremap <C-L> <Right>
inoremap <C-H> <Left>

" ----------------------
" Termianl Configuration
" ----------------------

" auto commands
au ExitPre * call Term_Exit()
au TerminalOpen * if &buftype == 'terminal' | setlocal bufhidden=hide nobuflisted | endif
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
au BufDelete * if &buftype == 'terminal' | echom "BufDelete" | endif
au BufUnload * if &buftype == 'terminal' | echom "BufUnload" | endif

" window movoment
tnoremap <C-J> <C-W><C-J>
tnoremap <C-K> <C-W><C-K>
tnoremap <C-L> <C-W><C-L>
tnoremap <C-H> <C-W><C-H>
tnoremap <ESC> <C-W>N
tnoremap <C-V> <C-W>"0

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

"let g:terminal_ansi_colors = [
  "\'#003440', '#dc312e', '#859901', '#b58900',
  "\'#268ad2', '#d33582', '#2aa197', '#eee8d5',
  "\'#003440', '#cb4b16', '#586d74', '#657b82',
  "\'#839495', '#6c6ec6', '#93a0a1', '#fdf6e3' ]

hi Terminal ctermbg=0

nnoremap <leader>l :ls<CR>:b<space>

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
