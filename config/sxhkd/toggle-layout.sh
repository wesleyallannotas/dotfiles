#!/bin/sh
atual=$(setxkbmap -query | awk '/layout/{print $2}')

if [ "$atual" = "br" ]; then
    setxkbmap -layout us -variant intl
else
    setxkbmap -layout br -variant abnt2
fi

pkill -USR1 -x sxhkd

