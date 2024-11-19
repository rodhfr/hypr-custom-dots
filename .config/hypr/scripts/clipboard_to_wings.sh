#!/bin/bash

SEND="rodhfr@wings"
PORT="22"

# Annoucing
notify-send -i clipboard "Copying clipboard to '$SEND'..."
# Try
if wl-paste --no-newline | ssh "$SEND" "env WAYLAND_DISPLAY='wayland-1' wl-copy > /dev/null 2>&1"; then
    pkill dunst # mako
    notify-send -i edit-copy "Clipboard copied to '$SEND'"
# Error
else
    pkill dunst # mako
    notify-send -i error "Failed to copy clipboard to '$SEND'"
fi

