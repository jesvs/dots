#!/bin/bash

DOTS_DIR="$(dirname "$0")/../.."
VIM_SRC_DIR="${DOTS_DIR}/src/vim"

if [ ! -f $VIM_SRC_DIR/configure ]; then
	git submodule init
	git submodule update
fi

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
libperl-dev
EOM

echo Building vim with options:
echo $VIM_OPTIONS

# install required packages
sudo apt-get -y install $REQUIRED_PACKAGES &&

# remove install vim
sudo apt-get -y remove vim vim-runtime gvim vim-common &&

cd $VIM_SRC_DIR &&
./configure $VIM_OPTIONS > /dev/null &&

make VIMRUNTIMEDIR=/usr/share/vim/vim80 > /dev/null &&

sudo checkinstall &&

sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim

