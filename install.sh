#!/bin/bash

ln -f ./.bashrc ~/.bashrc
ln -f ./.vimrc ~/.vimrc

mkdir -p ~/bin ~/.vim/{autoload,bundle,swap,undo}
ln -f ./vim-plugins ~/.vim/plugins

# Test for VCS
if hash git 2>/dev/null; then
    git="true"
    ln -f ./.gitconfig ~/.gitconfig
elif hash svn 2>/dev/null; then
    svn="true"
else
    echo "No VCS found, no good way to install Vim plugins"
    exit 1
fi

cd ~/.vim
# Use pathogen + voom because easy
[ -e autoload/pathogen.vim ] || curl -LSso autoload/pathogen.vim https://tpo.pe/pathogen.vim
[ -e ~/bin/voom ] || curl -LSso ~/bin/voom https://raw.githubusercontent.com/Rycieos/voom/master/voom
[ -x ~/bin/voom] || chmod +x ~/bin/voom

~/bin/voom
