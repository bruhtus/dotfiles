#!/usr/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do
  sleep i; done

#launch bar
polybar mainbar-i3 &
polybar secondbar-i3 &

echo "Bars launched..."
