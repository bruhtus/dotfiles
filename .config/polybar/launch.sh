#!/usr/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do
  sleep i; done

tray_monitor=$(xrandr | grep primary | awk '{print $1}') #grep primary monitor from xrandr

#launch bar
for m in $(polybar --list-monitors | cut -d":" -f1); do
  [ $m == $tray_monitor ] && MONITOR=$m polybar mainbar-i3 || MONITOR=$m polybar secondbar-i3 & #primary monitor launch mainbar-i3 and other monitor launch secondbar-i3
done

echo "Bars launched..."
