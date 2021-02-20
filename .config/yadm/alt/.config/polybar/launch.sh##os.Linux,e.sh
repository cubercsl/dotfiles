#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar
for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar -q -r top -c "$DIR"/config.ini &
    MONITOR=$m polybar -q -r bottom -c "$DIR"/config.ini &
done
