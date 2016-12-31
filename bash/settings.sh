#!/bin/bash

export HISTCONTROL=ingnoreboth:erasedups

if [[ $- == *i*  ]]; then
	bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
fi
