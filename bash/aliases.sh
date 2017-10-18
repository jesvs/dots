#!/bin/bash

if [ $(uname) = 'Darwin' ]; then
  alias ls="ls -G"
else
  alias ls="ls --color=auto"
fi

alias gs="git status"
alias co="checkout"
alias cob="checkout -b"

alias be="bundle exec"
alias ber="bundle exec rails"
alias bers="bundle exec rails server"
alias beg="bundle exec guard"
alias bep="bundle exec pakyow"
alias bepn="bundle exec pakyow new"
alias beps="bundle exec pakyow server"

function mkc {
    mkdir -p $1
    cd $1
}
