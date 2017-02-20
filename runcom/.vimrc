
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" utilities
Plugin 'tmhedberg/SimpylFold'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'sirver/ultisnips'

" languages
Plugin 'davidhalter/jedi-vim'
Plugin 'nvie/vim-flake8'
Plugin 'octol/vim-cpp-enhanced-highlight'

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

" key maps.

nnoremap <silent> <F10> :bd<CR>
nnoremap <silent> <F11> :bprevious<CR>        " buffer prev
nnoremap <silent> <F12> :bnext<CR>            " buffer next
nnoremap <silent> <F5> :!clear;python3 %<CR> " build

map <C-n> :NERDTreeToggle<CR>

