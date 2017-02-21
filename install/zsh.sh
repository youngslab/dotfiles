#!/usr/bin/env bash

# apt-get install zsh

# chsh -s 'which zsh'

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# apply custom theme
cp $DOTFILES_DIR/runcom/pure.zsh-theme ~/.oh-my-zsh/themes
