
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
set textwidth=70

" ident config.
set cindent
set ts=4 " Tab 너비
set shiftwidth=4 " 자동 인덴트할 때 너비

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

" key maps.

let mapleader = ","
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

nnoremap <leader>h  :noh<CR>


" map <F9> :w<CR>:python3 %<CR>"

nnoremap <silent> <F9>  :Bclose <CR>          " close buffer
nnoremap <silent> <F11> :bprevious<CR>        " buffer prev
nnoremap <silent> <F12> :bnext<CR>            " buffer next

nnoremap <silent> <F5> :!clear;python3 %<CR> " build


map <C-n> :NERDTreeToggle<CR>

nnoremap <silent> + :exe "resize +5" <CR>
nnoremap <silent> - :exe "resize -5" <CR>
nnoremap <silent> > :exe "vertical resize +5" <CR>
nnoremap <silent> < :exe "vertical resize -5" <CR>
" move vertically by visual line
nnoremap j gj
nnoremap k gk
