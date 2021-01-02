#!/bin/sh

xrandr --output $(xrandr | grep primary | awk '{print $1}') --auto --right-of $(xrandr | grep -v primary | grep " connected" | awk '{print $1}')
