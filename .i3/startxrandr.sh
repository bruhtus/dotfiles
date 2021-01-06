#!/bin/sh

[ $(xrandr | grep " connected" | wc -l) == 1 ] && xrandr --auto || xrandr --auto --output $(xrandr | grep primary | awk '{print $1}') --auto --right-of $(xrandr | grep -v primary | grep " connected" | awk '{print $1}')
