#!/usr/bin/env bash

BUNDLE_DIR=~/.vim/bundle

# Install/update Vundle

mkdir -p "$BUNDLE_DIR" && (git clone https://github.com/VundleVim/Vundle.vim "$BUNDLE_DIR"/Vundle.vim || (cd "$BUNDLE_DIR"/Vundle.vim  && git pull origin master))


# Install bundles
vim +PluginInstall +qall

# Compile YouCompleteMe
sudo apt-get install python-dev cmake clang
cd "$BUNDLE_DIR/../youcompleteme" && ./install.py

cd -
