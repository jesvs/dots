#!/bin/bash
USERFG=255
USERBG=2
HOSTFG=233
HOSTBG=3
GITFG=255
GITBG=5
DIRFG=255
DIRBG=4
ENDFG=15
ENDBG=234
DIRTYFG=180

RESET="\[\e[0m\]"

SEP=""
BRANCHSYMBOL=""

function fgcol {
    echo -en "\[\e[38;5;${1}m\]"
}
function bgcol {
    echo -en "\[\e[48;5;${1}m\]"
}
function defbg {
    echo -en "\[\e[49m\]"
}
function fgbg {
    fgcol $1
    bgcol $2
}
function gitStatus {
    if [ -d .git ] || $(git rev-parse --is-inside-work-tree 2>&1 | grep true); then
        echo -en " $BRANCHSYMBOL "
        echo -n $(git status | grep "On branch" | cut -f3 -d' ')
        echo -n ' '
        gitCommitStatus
    fi
}
function gitCommitStatus {
    COM_MSG=$(git status | tail -n1)
    if [[ $(echo $COM_MSG | grep -i added) = *added* ]]; then
        CHANGES=$(git ls-files --others --modified | wc -l | awk {'print $1'})
        echo -n "𝛿$CHANGES "
    fi
}

PS1="$(fgbg $USERFG $USERBG) \u \
$(fgbg $USERBG $HOSTBG)${SEP}\
$(fgcol $HOSTFG) \h \
$(fgbg ${HOSTBG} ${DIRBG})${SEP}\
$(fgcol $DIRFG) \w \
$(fgbg $DIRBG $GITBG)${SEP}\
$(fgbg $GITFG $GITBG)\$(gitStatus)\
$(fgbg $GITBG $ENDBG)${SEP}\
$(fgbg $ENDFG $ENDBG) \$ \
$(fgcol $ENDBG)$(defbg)${SEP}$RESET "

