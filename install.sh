#!/bin/bash

ln -f ./.bashrc ~/.bashrc
ln -f ./.vimrc ~/.vimrc
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/undo
mkdir -p ~/.vim/swap
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

