#!/bin/bash

read -r -d '' VIM_OPTIONS << EOM
--with-features=huge
--enable-multibyte
--enable-rubyinterp=yes
--enable-pythoninterp=yes
--with-python-config-dir=/usr/lib/python2.7/config
--enable-python3interp=yes
--with-python3-config-dir=/usr/lib/python3.5/config
--enable-perlinterp=yes
--enable-luainterp=yes
--enable-cscope
--prefix=/usr
EOM

read -r -d '' REQUIRED_PACKAGES << EOM
build-essential
libncurses5-dev
lua5.1-dev
lua5.1
ruby-dev
ruby
python3-dev
checkinstall
EOM

echo Installing vim with options:
echo $VIM_OPTIONS

# install required packages
sudo apt-get install $REQUIRED_PACKAGES &&

# remove install vim
sudo apt-get remove vim vim-runtime gvim vim-common &&

# get vim from git
if [ -d vim ]; then
	cd vim
	git pull
else
	git clone https://github.com/vim/vim.git &&
	cd vim
fi
./configure $VIM_OPTIONS > /dev/null &&

make VIMRUNTIMEDIR=/usr/share/vim/vim80 > /dev/null &&

sudo checkinstall &&

sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim

