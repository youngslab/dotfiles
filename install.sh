#!/usr/bin/env bash

# pacakges.
sudo apt-get -y update && sudo apt -y upgrade && sudo apt install -y \
  cmake g++ curl vim clang-format silversearcher-ag ripgrep \
  clang-tidy tmux cscope universal-ctags \
  python3-pip pkg-config \
  clangd

sudo pip3 install conan \
  cmakelang # cmake formatter


if [ "$?" -ne 0 ]; then
  echo "You need proper priviliedged"
  exit -1
fi

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
ln -sfv "$DOTFILES_DIR/scripts" ~/.scripts

# 6. common shell runcom files
ln -sfv "$DOTFILES_DIR/runcom/.shellrc" ~
ln -sfv "$DOTFILES_DIR/runcom/.shellrc_aliases" ~

# 7. customized bashrc
ln -sfv "$DOTFILES_DIR/runcom/.bashrc_customized" ~
printf "\n\n# Load a bashrc customized runcome file.
\ntest -f ~/.bashrc_customized && . \$_\n" >> ~/.bashrc

# 8. customized zshrc
./install/zsh.sh
ln -sfv "$DOTFILES_DIR/runcom/.zshrc_customized" ~
printf "\n\n# Load a zshrc customized runcome file. \
  \ntest -f ~/.zshrc_customized && . \$_\n" >> ~/.zshrc

# 8. vim
./install/vim.sh
