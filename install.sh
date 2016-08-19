#!/bin/bash

mkdir -p ~/bin ~/.vim
ln -f ./.bashrc ~/.bashrc
ln -f ./.vimrc ~/.vimrc
ln -f ./vim-plugins ~/.vim/plugins
mkdir -p ~/.vim/{autoload,bundle,swap,undo}

# Test for VCS
if hash git 2>/dev/null; then
    ln -f ./.gitconfig ~/.gitconfig
fi

# Use pathogen + voom because easy
[ -e ~/.vim/autoload/pathogen.vim ] || curl -LSso ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/Rycieos/vim-pathogen/master/autoload/pathogen.vim
[ -e ~/bin/voom ] || curl -LSso ~/bin/voom https://raw.githubusercontent.com/Rycieos/voom/master/voom
[ -x ~/bin/voom ] || chmod +x ~/bin/voom

~/bin/voom
