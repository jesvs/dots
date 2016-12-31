# user domain dir $
USERFG=154
USERBG=29
HOSTFG=233
HOSTBG=95
DIRFG=255
DIRBG=26
ENDFG=15
GITFG=219
GITBG=53
ENDBG=234

RESET="\[\e[0m\]"

SEP=$'\ue0b0'

function fgcol {
    echo -en "\[\e[38;5;${1}m\]"
}
function bgcol {
    echo -en "\[\e[48;5;${1}m\]"
}
function fgbg {
    fgcol $1
    bgcol $2
}
function gitbranch {
    if [ -d .git ] || $(git rev-parse --is-inside-work-tree 2>&1 | grep true); then
        echo -en ' \ue0a0 '
        git branch | grep '^\*' | cut -f2 -d' '
    fi
}

PS1="$(fgbg $USERFG $USERBG) \u\
$(fgbg $USERBG $HOSTBG)${SEP}\
$(fgcol $HOSTFG) \h\
$(fgbg ${HOSTBG} ${DIRBG})${SEP}\
$(fgcol $DIRFG) \w\
$(fgbg $DIRBG $GITBG)${SEP}\
$(fgbg $GITFG $GITBG)\[\$(gitbranch)\]\
$(fgbg $GITBG $ENDBG)${SEP}\
$(fgbg $ENDFG $ENDBG) \$\
$(fgbg $ENDBG 0)${SEP}$RESET "

