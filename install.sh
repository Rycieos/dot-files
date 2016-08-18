#!/bin/bash

ln -f ./.bashrc ~/.bashrc
ln -f ./.vimrc ~/.vimrc

mkdir -p ~/bin ~/.vim/{autoload,bundle,swap,undo}

# Test for VCS
if hash git 2>/dev/null; then
    ln -f ./.gitconfig ~/.gitconfig
elif hash svn 2>/dev/null; then
    # Remove git plugins, since we don't have git
    sed '/git/d' ./vim-plugins > ./vim-plugins.tmp
    mv ./vim-plugins.tmp ./vim-plugins
else
    echo "No VCS found, no good way to install Vim plugins"
    exit 1
fi

ln -f ./vim-plugins ~/.vim/plugins
cd ~/.vim
# Use pathogen + voom because easy
[ -e autoload/pathogen.vim ] || curl -LSso autoload/pathogen.vim https://tpo.pe/pathogen.vim
[ -e ~/bin/voom ] || curl -LSso ~/bin/voom https://raw.githubusercontent.com/Rycieos/voom/master/voom
[ -x ~/bin/voom ] || chmod +x ~/bin/voom

~/bin/voom
