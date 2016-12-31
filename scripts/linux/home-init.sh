#!/bin/bash

sudo apt-get -y install curl

mkdir -p ~/.vim
ln -sf ~/.dots/vim/vimrc ~/.vimrc

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
