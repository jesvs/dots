# dots

dot files and utility scripts for setting up new linux/macOS machines.

## vim from source

Grab the vim source by initializing and updating the git submodules:

```
git submodule init
git submodule update
~/.dots/scripts/debian8/vim-from-source.sh
```

## nodejs
```
~/.dots/scripts/debian8/install-nodejs.sh
```

## tern for vim

Make sure nodejs is installed globally (nvm won't work).
```
cd ~/.vim/plugged/tern_for_vim
npm install
cd ~/.vim/plugged/completor.vim
make js
```
