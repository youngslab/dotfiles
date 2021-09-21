#!/bin/bash

# Plug
#-----
# 1. Donwnload Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# 2. Install vim plug's plugins
vim +PlugInstall

# Coc
#----
# 1. Install nodejs
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs

# 2. Build
cd ~/.vim/bundle/coc.nvim
yarn install
yarn build

# 3. Install coc plugins
vim -c ":CocInstall coc-sh coc-clangd coc-cmake coc-python"
