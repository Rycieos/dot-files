#!/bin/bash

ln -f ./.bashrc ~/.bashrc
ln -f ./.vimrc ~/.vimrc

mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/undo
mkdir -p ~/.vim/swap

# Test for git
if hash git 2>/dev/null; then
    ln -f ./.gitconfig ~/.gitconfig
    # Use Vundle because it uses git and is easy
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
elif hash svn 2>/dev/null; then
    cd ~/.vim/bundle
    # With no way to update, we need to clean up
    rm -rf ./*
    # Use pathogen because it is simple
    svn co https://github.com/tpope/vim-pathogen.git/trunk vim-pathogen
    plugins=$(grep "^Plugin '" ~/.vimrc | sed "s/^Plugin '//g; s/'$//g")

    for plugin in "${plugins[@]}"; do
        svn co "https://github.com/${plugin}.git/trunk" "${plugin}"
    done

    # Edit .vimrc to work without Vundle
    sed -i.bak "|^Plugin '*'$|dg; |^set rtp+=~/.vim/bundle/Vundle.vim$|d; |^call vundle#end()$|d; s|vundle#begin|pathogen#infect|" ~/.vimrc

    # Don't need this stuff, since we can't update
    rm */README* */Makefile */CONTRIBUTING* */LICENSE* */.travis*
    rm -rf */.svn */.git* */test
else
    echo "No VCS found, no way to install Vim plugins"
fi

