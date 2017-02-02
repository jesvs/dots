#!/bin/bash
export PROMPT_DIRTRIM=1
ncolors=$(tput colors)
if test -n "$ncolors" && test $ncolors -ge 16; then
  # true color palette
  userBG="145;240;242"
  userFG="46;119;101"
  hostBG="249;79;53"
  hostFG="140;15;9"
  dirBG="255;166;30"
  dirFG="230;86;11"
  gitBG="253;220;105"
  gitFG="155;122;38"
  endBG="133;102;82"
  endFG="32;20;15"
  dirtyFG="180;20;20"
  sepSymbol=""
  endSymbol=$sepSymbol
  branchSymbol=""
  sp=" "
else
  userFG=32
  userBG=49
  hostFG=33
  hostBG=49
  dirFG=34
  dirBG=49
  gitFG=35
  gitBG=49
  endFG=36
  endBG=49
  dirtyFG=31
  sepSymbol="│"
  branchSymbol="ß"
  endSymbol=""
  sp=""
fi

resetCode="\[\e[0m\]"


function fgcol {
    echo -en "\[\e[38;2;${1}m\]"
}
function bgcol {
    echo -en "\[\e[48;2;${1}m\]"
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
        echo -en "${sp}${branchSymbol} "
        echo -n $(git status | grep "On branch" | cut -f3 -d' ')
        echo -n "${sp}"
        gitCommitStatus
    fi
}
function gitCommitStatus {
    return 0
    COM_MSG=$(git status | tail -n1)
    if [[ $(echo $COM_MSG | grep -i added) = *added* ]]; then
        CHANGES=$(git ls-files --modified | wc -l | awk {'print $1'})
        echo -n "𝛿$CHANGES "
    fi
}

PS1="$(fgbg $userFG $userBG)${sp}\u${sp}\
$(fgbg $userBG $hostBG)${sepSymbol}\
$(fgcol $hostFG)${sp}\h${sp}\
$(fgbg $hostBG $dirBG)${sepSymbol}\
$(fgcol $dirFG)${sp}\w${sp}\
$(fgbg $dirBG $gitBG)${sepSymbol}\
$(fgbg $gitFG $gitBG)\$(gitStatus)\
$(fgbg $gitBG $endBG)${sepSymbol}\
$(fgbg $endFG $endBG)${sp}\$${sp}\
$(fgcol $endBG)$(defbg)${endSymbol}$resetCode "

