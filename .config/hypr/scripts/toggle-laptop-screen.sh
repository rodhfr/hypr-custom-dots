#!/bin/bash

# File to track the state of the script (running or not)
STATE_FILE="hotkey_switch"

# Check if the script is already running
if [ -f "$STATE_FILE" ]; then
    # If running, stop the script (e.g., kill the process)
    pkill -f "monitor.sh"
    rm "$STATE_FILE"
    pkill dunst
    dunst &
    notify-send -i laptop "Laptop Screen" "Auto power state disabled"
else
    # If not running, start the script
    nohup bash monitor.sh > /dev/null 2>&1 &
    touch "$STATE_FILE"
    pkill dunst
    dunst &
    notify-send -i laptop "Laptop Screen" "Auto power state enabled"
fi

