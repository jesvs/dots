#!/bin/bash
PLUGINS_FILE="$HOME/.vim/vimrc_module_plugins"

read dialog <<< "$(which whiptail dialog 2> /dev/null)"

[[ "$dialog" ]] || {
    echo 'neither whiptail nor dialog found' >&2
    exit 1
}

if [ ! $(uname) = 'Darwin' ]; then
    sudo apt-get -y install curl > /dev/null
fi

mkdir -p ~/.vim/{backup,swap,undo}
touch "$PLUGINS_FILE"

ln -sf ~/.dots/vim/vimrc ~/.vimrc

if [ ! -f ~/.vim/autoload/plug.vim ]; then
    curl -sfLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

PLUGINS=$(
NEWT_COLORS='
	root=,blue
	window=,lightgray
	border=,lightgray
	checkbox=black,lightgray
	button=,red
' \
"$dialog" --title "vim plugins" --separate-output \
	--checklist "Select plugins" 20 70 10 \
	fatih/vim-go 'Go development' on \
	jiangmiao/auto-pairs 'Quotes in pair' on \
	kien/ctrlp.vim 'Fuzzy file finder' on \
	maralla/completor.vim 'Async completion framework' on \
	mattn/emmet-vim 'Toolkit for webdevs' on \
	tomasr/molokai 'Molokai color scheme' on \
	tpope/vim-endwise 'Wisely add "end" in ruby' on \
	tpope/vim-fugitive 'Git wrapper' on \
	tpope/vim-surround 'quoting/parenthesizing' on \
	vim-airline/vim-airline 'Lean & mean status' on \
	vim-airline/vim-airline-themes 'Airline themes' on \
    ternjs/tern_for_vim 'Tern-based JS editing' on \
    w0ng/vim-hybrid 'A dark colour scheme' on \
	3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
	for PLUGIN in $PLUGINS; do
		echo Plug \'$PLUGIN\' >> "$PLUGINS_FILE"
	done
	# remove duplicates from file
	cp "$PLUGINS_FILE" "$PLUGINS_FILE".orig
	awk '!a[$0]++' "$PLUGINS_FILE".orig > "$PLUGINS_FILE"
	rm "$PLUGINS_FILE".orig
	vim -c ":PlugInstall"
else
	echo "No plugins selected."
fi
