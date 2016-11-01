#!/bin/bash

cd "$(dirname "$0")"
dir="$(pwd)"

mkdir -p ~/bin ~/.config ~/.vim/{autoload,bundle,swap,undo}
ln -fs "${dir}"/.bashrc ~/.bashrc
ln -fs "${dir}"/.config/* ~/.config/
ln -fs "${dir}"/.vim/* ~/.vim/

# Cleanup stale symlinks
for i in ~/.*; do
  if [ -h "$i" ] && [ ! -f "$i" ]; then
    echo "Deleting stale link: $i"
    rm $i
  fi
done

# Use pathogen + voom because easy
[ -e ~/.vim/autoload/pathogen.vim ] || curl -LSso ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/Rycieos/vim-pathogen/master/autoload/pathogen.vim
[ -e ~/bin/voom ] || curl -LSso ~/bin/voom https://raw.githubusercontent.com/Rycieos/voom/master/voom
[ -x ~/bin/voom ] || chmod +x ~/bin/voom

~/bin/voom
