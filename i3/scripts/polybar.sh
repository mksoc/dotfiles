#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Wait for wal to setup colors correctly
while pgrep -x wal > /dev/null; do sleep 1; done

# Launch polybar
polybar top &