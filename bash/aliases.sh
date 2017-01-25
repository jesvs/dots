#!/bin/bash

if [ $(uname) = 'Darwin' ]; then
  alias ls="ls -G"
else
  alias ls="ls --color=auto"
fi

alias gs="git status"
alias co="checkout"
alias cob="checkout -b"

function mkc {
    mkdir -p $1
    cd $1
}
