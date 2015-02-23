#!/bin/bash

# Dotfiles install symlink.
# (don't run this if you don't want to overwrite all these dotfiles)

pwd=$(pwd)
pre="$pwd/"

ln -sfv $pre.vimrc ~
ln -sfv $pre.Xmodmap ~
ln -sfv $pre.bash_profile ~
ln -sfv $pre.bashrc ~
ln -sfv $pre.gitconfig ~
ln -sfv $pre.xinitrc ~

mkdir -p ~/.config
ln -sfv $pre.config/redshift.conf ~/.config/redshift.conf

mkdir -p ~/.i3
ln -sfv $pre.i3/config ~/.i3/config
ln -sfv $pre.i3/conkystatus ~/.i3/conkystatus
ln -sfv $pre.i3/i3dunst.conf ~/.i3/i3dunst.conf
ln -sfv $pre.i3/i3status.conf ~/.i3/i3status.conf

mkdir -p ~/.vim/colors
ln -sfv $pre.vim/colors/*.vim ~/.vim/colors/
