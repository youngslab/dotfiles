
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" For Mac/Linux users
call plug#begin('~/.vim/bundle')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic', {'for': 'cpp'}

" key binding 
Plug 'tpope/vim-unimpaired'

Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' , 'for': 'cpp'}
Plug 'derekwyatt/vim-fswitch'
" Test
Plug 'alepez/vim-gtest', {'for': 'cpp'}
Plug 'tpope/vim-fugitive'

Plug 'djoshea/vim-autoread'
Plug 'tmhedberg/SimpylFold'
Plug 'sirver/ultisnips'
Plug 'milkypostman/vim-togglelist'

" build
Plug 'tpope/vim-dispatch'

" THEMES
Plug 'junegunn/goyo.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'

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
call plug#end()


" basic
set nocompatible
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


" indent config.
set autoindent
set cindent
set expandtab " tab to space
set tabstop=2 
set shiftwidth=2

" Hybrid line number ( relative + absolute)
set number relativenumber
set nu rnu


" themes
set background=dark
colorscheme solarized

" plugin - airline
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1 " for buffers
let g:airline_powerline_fonts = 1            " symbols
set laststatus=2                             " need to show the power line.

" plugin - nerd

" plugin - syntax
let g:cpp_class_scope_highlight = 1

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1

" menu autocompletion
set wildmenu
set wildmode=longest:full,full " Display Vim command mode autocompletion list

" key maps.

let mapleader = ","



" map <F9> :w<CR>:python3 %<CR>"


nnoremap <silent> <F5> :!clear;python3 %<CR> " build



" move vertically by visual line
nnoremap j gj
nnoremap k gk

" --------------------------------------------------
" configure - build 
set makeprg=ninja\ -C\ ./nbuild
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
let g:clang_format#auto_format = 1
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
let g:DoxygenToolkit_authorName="Jaeyqwoung Park"
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

