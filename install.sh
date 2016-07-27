#!/bin/bash

ln -f ./.bashrc ~/.bashrc

mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/undo
mkdir -p ~/.vim/swap

# Test for git
if hash git 2>/dev/null; then
    ln -f ./.vimrc ~/.vimrc
    ln -f ./.gitconfig ~/.gitconfig
    # Use Vundle because it uses git and is easy
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
elif hash svn 2>/dev/null; then
    cp -f ./.vimrc ~/.vimrc
    cd ~/.vim/bundle
    # With no way to update, we need to clean up
    rm -rf ./*
    # Use pathogen because it is simple
    svn co https://github.com/tpope/vim-pathogen.git/trunk vim-pathogen
    plugins="$(grep "^Plugin '" ~/.vimrc | grep -v "Vundle" | grep -v "git" | sed "s/^Plugin '//g; s/'$//g")"

    for plugin in ${plugins}; do
        echo "Installing $plugin"
        svn co "https://github.com/${plugin}.git/trunk" $(basename "${plugin}")
    done

    # Edit .vimrc to work without Vundle
    # Must be done this way to support POSIX sed
    sed -n "/^Plugin '*'/!p" ~/.vimrc > ~/.vimrc.tmp
    sed -n "/^set rtp+=~\/.vim\/bundle\/Vundle.vim$/!p" ~/.vimrc.tmp > ~/.vimrc
    sed -n "/^call vundle#end()$/!p" ~/.vimrc > ~/.vimrc.tmp
    sed "s/vundle#begin/pathogen#infect/" ~/.vimrc.tmp > ~/.vimrc
    rm ~/.vimrc.tmp

    # Don't need this stuff, since we can't update
    rm */README* */Makefile */CONTRIBUTING* */LICENSE* */.travis* 2>/dev/null
    rm -rf */.svn */.git* */test 2>/dev/null
else
    echo "No VCS found, no way to install Vim plugins"
fi

