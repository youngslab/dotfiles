#!/usr/bin/env bash

# pacakges.
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install cmake g++ curl vim clang-format silversearcher-ag \
                     clang-tidy tmux

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR EXTRA_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Update dotfiles itself first
[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# Bunch of symlinks
# 1. vimrc
ln -sfv "$DOTFILES_DIR/runcom/.vimrc" ~

# 2. dircolors for solarized dark
ln -sfv "$DOTFILES_DIR/runcom/.dircolors" ~

# 3. gitconfig
ln -sfv "$DOTFILES_DIR/runcom/.gitconfig" ~

# 4. tmux
ln -sfv "$DOTFILES_DIR/runcom/.tmux.conf" ~

# 5. misc
ln -sfv "$DOTFILES_DIR/runcom/scripts" ~/.scripts

# 6. customized bashrc
ln -sfv "$DOTFILES_DIR/runcom/.bashrc_customized" ~
printf "\n\n# Load a bashrc customized runcome file. \
        \ntest -f ~/.bashrc_customized && . \$_\n" >> ~/.bashrc

# 7. zsh
./install/zsh.sh
ln -sfv "$DOTFILES_DIR/runcom/.zshrc_customized" ~
printf "\n\n# Load a zshrc customized runcome file. \
        \ntest -f ~/.zshrc_customized && . \$_\n" >> ~/.zshrc

# 8. vim
./install/vim.sh
