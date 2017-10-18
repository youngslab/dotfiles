mkdir -p "$BUNDLE_DIR" && (git clone https://github.com/VundleVim/Vundle.vim "$BUNDLE_DIR" || (cd "$BUNDLE_DIR" && git pull origin master))

# Install bundles
vim +PluginInstall +qall

# Compile YouCompleteMe
sudo apt-get install python-dev cmake clang
cd "$BUNDLE_DIR/../youcompleteme" && ./install.py

cd -
