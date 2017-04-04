#!/bin/bash
############################
# makesymlinks.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/Documents/dotfiles
############################

########## Variables

dir=~/Documents/dotfiles                    # dotfiles directory
olddir=~/Documents/dotfiles_old             # old dotfiles backup directory
files="bashrc zshrc xbindkeysrc gitconfig gitignore tmux.conf vimrc snippetrc"    # list of files/folders to symlink in homedir
# profile

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file $olddir/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done
