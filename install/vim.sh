#!/bin/bash

# install vim
# if ubuntu over 9, using vim-gtk3 else vim-gnome
sudo apt install vim-gtk3 curl cscope
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall

