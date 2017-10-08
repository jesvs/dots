#!/bin/bash
plugs_file="$HOME/.vim/vimrc_module_plugins"
mkdir -p ~/.vim/{backup,swap,undo}

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cat <<PLUGS >> "$plugs_file"
Plug 'danilo-augusto/vim-afterglow'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
PLUGS
