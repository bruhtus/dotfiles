#!/bin/sh

userresources=$HOME/.config/usr/xresources
userprofile=$HOME/.config/usr/profile

# merge in defaults and keymaps

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

[ -f "$userprofile" ] && . "$userprofile"

exec i3
