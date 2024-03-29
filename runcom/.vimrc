if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ----------------------
" Plug Configuration
" ----------------------

call plug#begin('~/.vim/bundle')

Plug 'scrooloose/nerdcommenter'

Plug 'scrooloose/nerdtree'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-unimpaired'

Plug 'derekwyatt/vim-fswitch'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'tpope/vim-fugitive'

Plug 'djoshea/vim-autoread'

Plug 'will133/vim-dirdiff'

Plug 'tpope/vim-dispatch'

Plug 'vim-airline/vim-airline'

Plug 'vim-airline/vim-airline-themes'

Plug 'altercation/vim-colors-solarized'

Plug 'brookhong/cscope.vim'

"Plug 'craigemery/vim-autotag'

Plug 'rhysd/vim-clang-format', {'for': 'cpp'}

Plug 'vim-scripts/DoxygenToolkit.vim', {'for': 'cpp'}

Plug 'octol/vim-cpp-enhanced-highlight'   , {'for': ['cpp', 'c']}

Plug 'scrooloose/syntastic', {'for': ['python', 'cpp', 'c'] }

" Haskell
Plug 'eagletmt/ghcmod-vim' , {'for': 'haskell'}
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'eagletmt/neco-ghc', {'for': 'haskell'}
Plug 'neovimhaskell/haskell-vim' , {'for': 'haskell'}
Plug 'alx741/vim-hindent', {'for': 'haskell'}

" Rust
Plug 'rust-lang/rust.vim'

" CMake, Shell - formatter
Plug 'chiel92/vim-autoformat'

"" Python
"Plug 'klen/python-mode' , {'for': 'python', 'branch': 'develop'}

" Tagbar
Plug 'liuchengxu/vista.vim'

call plug#end()

" -------------------------
" VIM default Configuration
" -------------------------

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
set number relativenumber
set nu rnu

" indent config.
" set autoindent
set cindent
set smartindent

" linux style
" set expandtab " tab to space
set tabstop=8
set shiftwidth=2

" Hybrid line number ( relative + absolute)
set number relativenumber
set nu rnu

" Clipboard
if g:os == "Darwin"
  set clipboard=unnamed " use OS clipboard
elseif g:os == "Linux"
  set clipboard=unnamedplus " use OS clipboard
endif

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
  augroup WSLYank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
  augroup END
endif

" themes
set background=dark
colorscheme solarized

" Window
set splitbelow
set splitright

" List Mode
" show hidden characters in Vim
set list
" settings for hidden chars (or set lcs=.....)
"set listchars=tab:▒░,trail:▓,nbsp:░
set listchars=tab:··,trail:·,nbsp:·


" menu autocompletion
set wildmenu
set wildmode=longest:full,full " Display Vim command mode autocompletion list

" key maps.
let mapleader = ","

" Features: insert mode cursor movement
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
inoremap <C-b> <C-o>h
inoremap <C-f> <C-o>l

" move vertically by visual line
nnoremap j gj
nnoremap k gk


nnoremap <silent> \h :noh<CR>

" configure - utilities
nmap \n :setlocal number! relativenumber!<CR>

nmap \o :set paste!<CR>
nmap \cw <C-W>q " close buffer
nmap \r :e!<CR> " reload w/o saving

nmap <script> <silent> \l :call ToggleLocationList()<CR>
nmap <script> <silent> \q :call ToggleQuickfixList()<CR>

" --------------------------------------------------
" configure - (b)uffers
nnoremap <silent> \b :bp<bar>sp<bar>bn<bar>bd<CR> " [close]

" configure - (p)review
nnoremap <silent> \p :pclose <CR> " [close]

" configure - (q)uick
nnoremap <silent> \q :cclose <CR>

" configure - (e)tc - quick, loc, preview..
nnoremap <silent> \e :cclose <CR> :lclose<CR> :pclose <CR>

" close (w)indow
nnoremap <silent> \w :q <CR>  " [close]
nnoremap <silent> [w <C-W>h   " [next]
nnoremap <silent> ]w <C-W>l   " [prev]

" --------------------------------------------------
" configure - (w)indows

" normal mode - window size
nnoremap <silent> + :exe "resize +5" <CR>
nnoremap <silent> - :exe "resize -5" <CR>
nnoremap <silent> > :exe "vertical resize +5" <CR>
nnoremap <silent> < :exe "vertical resize -5" <CR>

" normal mode - window movement
nmap \1 1<C-W><C-W>
nmap \2 2<C-W><C-W>
nmap \3 3<C-W><C-W>
nmap \4 4<C-W><C-W>

" normal mode - window movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" normal mode - refresh
nnoremap <leader>r :redraw!<CR>

" insert mode - cursor movment
inoremap <C-J> <Down>
inoremap <C-K> <Up>
inoremap <C-L> <Right>
inoremap <C-H> <Left>

" terminal mode - window movoment
tnoremap <C-J> <C-W><C-J>
tnoremap <C-K> <C-W><C-K>
tnoremap <C-L> <C-W><C-L>
tnoremap <C-H> <C-W><C-H>

" terminal - siwtch to normal mode
tnoremap <C-Q> <C-W>N

" terminal - paste 0 resister
tnoremap <C-V> <C-W>"0

" history ctrl+p && ctlr+n
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" --------------------------------------------------
" Plugin - Dispatch
" --------------------------------------------------
"let g:build_folder=./build
nnoremap <F5> :Dispatch cmake --build ./build<CR>

nnoremap <F6> :Dispatch mkdir -p build
      \ && conan install --build=missing -if ./build .
      \ && cmake -B./build -H. -G Ninja
      \ -DCMAKE_EXPORT_COMPILE_COMMANDS=y
      \ -DCMAKE_BUILD_TYPE=Debug
      \ -DCMAKE_MODULE_PATH=`pwd`/build
      \ && ln -svf ./build/compile_commands.json . <CR>

" -- generate compilation
nnoremap <F7> :CocRestart <CR>

" --------------------------------------------------
" Plugin - NerdTree
" --------------------------------------------------
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" close after jump
let NERDTreeQuitOnOpen=1

" --------------------------------------------------
" Plugin - ClangFormat
" --------------------------------------------------
let g:clang_format#auto_format = 0
let g:clang_format#style_options = {
      \ "IndentWidth" : 2,
      \ "SortIncludes" : "false",
      \ "Standard" : "C++11" }
" let g:clang_format#detect_style_file = 1
let g:clang_format#code_style = "llvm"

" --------------------------------------------------
" Plugin - ClangFormat
" --------------------------------------------------
nnoremap <leader>o :FSHere<CR>
let g:fsnonewfiles = 'on'

" --------------------------------------------------
" Plugin - Doxygen
" --------------------------------------------------
let g:DoxygenToolkit_authorName="Jaeyoung Park"
let g:DoxygenToolkit_licenseTag="My own license"

" --------------------------------------------------
" Plugin - Powerline
" --------------------------------------------------
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1 " for buffers
let g:airline_powerline_fonts = 1            " symbols
set laststatus=2                             " need to show the power line.

" --------------------------------------------------
" Plugin - Rust
" --------------------------------------------------
let g:rustfmt_autosave = 1

" --------------------------------------------------
" Plugin - Load
" --------------------------------------------------
" load plugin configurations which are defined externally
source ~/.dotfiles/runcom/vim/plugconf/coc.vim
source ~/.dotfiles/runcom/vim/plugconf/fzf.vim
source ~/.dotfiles/runcom/vim/plugconf/term.vim
source ~/.dotfiles/runcom/vim/plugconf/cscope.vim
source ~/.dotfiles/runcom/vim/plugconf/syntastic.vim
source ~/.dotfiles/runcom/vim/plugconf/vista.vim

" --------------------------------------------------
" Plugin - vim-autoformat
" --------------------------------------------------
nnoremap <F3> :Autoformat <CR> :w <CR>
inoremap <F3> <esc> :Autoformat <CR> :w <CR>

nnoremap <F4> :q <CR>
