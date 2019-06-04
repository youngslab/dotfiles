#!/usr/bin/env bash

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Oh my zsh plugin 
# syntax highlight
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# auto suggestion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# auto jump
brew install autojump


# apply custom theme
ln -sfv "$DOTFILES_DIR/runcom/refined_2.zsh-theme" ~/.oh-my-zsh/themes/refined_2.zsh-theme
