#!/usr/bin/env bash

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# apply custom theme
ln -sfv "$DOTFILES_DIR/runcom/refined_2.zsh-theme" ~/.oh-my-zsh/themes/refined_2.zsh-theme
