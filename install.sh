#!/usr/bin/env bash


# pacakges.
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install cmake g++ curl vim clang-format silversearcher-ag clang-tidy

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR EXTRA_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Update dotfiles itself first
[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# Bunch of symlinks
ln -sfv "$DOTFILES_DIR/runcom/.vimrc" ~
ln -sfv "$DOTFILES_DIR/runcom/.bashrc" ~
ln -sfv "$DOTFILES_DIR/runcom/.inputrc" ~
ln -sfv "$DOTFILES_DIR/runcom/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/runcom/.tmux.conf" ~
#ln -sfv "$DOTFILES_DIR/runcom/.zshrc" ~
ln -sfv "$DOTFILES_DIR/runcom/.profile" ~
ln -sfv "$DOTFILES_DIR/runcom/.dircolors" ~
ln -sfv "$DOTFILES_DIR/runcom/.misc.sh" ~

ln -sfv "$DOTFILES_DIR/scripts" ~/.scripts

#./install/zsh.sh
./install/vundle.sh
