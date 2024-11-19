#!/bin/bash

SEND="u0_a300@helium"
PORT="8022"

# Annoucing
notify-send -i clipboard "Copying clipboard to '$SEND'..."
# Try
if wl-paste --no-newline | ssh "$SEND" -p "$PORT" "termux-clipboard-set"; then
    pkill dunst # mako
    notify-send -i edit-copy "Clipboard copied to '$SEND'"
# Error
else
    pkill dunst # mako
    notify-send -u critical -i dialog-error "Failed to copy clipboard to '$SEND'"
fi


