#!/bin/bash

if [ $(uname) = 'Darwin' ]; then
  alias ls="ls -G"
else
  alias ls="ls --color=auto"
fi

alias gs="git status"
