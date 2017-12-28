
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" For Mac/Linux users
call plug#begin('~/.vim/bundle')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rhysd/vim-clang-format'
call plug#end()

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" utilities
Plugin 'tmhedberg/SimpylFold'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'sirver/ultisnips'

" CMake
Plugin 'pboettch/vim-cmake-syntax'

" languages
Plugin 'davidhalter/jedi-vim'
Plugin 'nvie/vim-flake8'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'valloric/youcompleteme'

" THEMES
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'

call vundle#end()
filetype plugin indent on

" basic
set nocompatible
set term=screen-256color  " support 256 color in term
set nu                   " line numbering
filetype off
syntax on
set t_Co=256
set t_ut=
set incsearch " search as characters are entered
set hlsearch " highlight matches
set backspace=indent,eol,start
set textwidth=80
set encoding=utf-8


" ident config.
set cindent
set ts=4 " Tab 
set shiftwidth=4 " 

" themes
set background=dark
colorscheme solarized

" plugin - airline
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1 " for buffers
let g:airline_powerline_fonts = 1            " symbols
set laststatus=2                             " need to show the power line.

" plugin - nerd
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" plugin - syntax
let g:cpp_class_scope_highlight = 1

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:ycm_confirm_extra_conf = 0 

" menu autocompletion
set wildmenu
set wildmode=longest:full,full " Display Vim command mode autocompletion list

" key maps.

let mapleader = ","
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

nnoremap <leader>h  :noh<CR>
nnoremap <leader>t  :Files<CR>
nnoremap <leader>b  :Buffers<CR>


" map <F9> :w<CR>:python3 %<CR>"

nnoremap <silent> <F9>  :bd<CR>          " close buffer
nnoremap <silent> <F11> :bprevious<CR>        " buffer prev
nnoremap <silent> <F12> :bnext<CR>            " buffer next

nnoremap <silent> <F5> :!clear;python3 %<CR> " build
noremap <F3> :<C-U>!clear && mkdir -p build && cd build && cmake -G Ninja .. && cd .. <CR>
noremap <F4> :<C-U>!clear && cd build && ninja && cd .. <CR>

map <C-n> :NERDTreeToggle<CR>

nnoremap <silent> + :exe "resize +5" <CR>
nnoremap <silent> - :exe "resize -5" <CR>
nnoremap <silent> > :exe "vertical resize +5" <CR>
nnoremap <silent> < :exe "vertical resize -5" <CR>
" move vertically by visual line
nnoremap j gj
nnoremap k gk

" --------------------------------------------------
" configure - clang format
let g:clang_format#auto_format = 1
" let g:clang_format#detect_style_file = 1
" let g:clang_format#code_style = "llvm"

" key map 
autocmd FileType h, hpp, c, cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType h, hpp, c, cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

" --------------------------------------------------
" configure - syntastatic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


