#!/bin/bash
# CLIENT TO SEND CLIPBOARD
SEND="u0_a300@helium"
PORT="8022"
# Annoucing
notify-send -i clipboard "Copying clipboard to '$SEND'..."
# CLIPBOARD FROM:
CLIPBOARD=$(wl-paste --no-newline)
# Try:
if ssh -p "$PORT" "$SEND" "termux-clipboard-set '$CLIPBOARD'"; then
    dunstctl close # mako
    notify-send -i edit-copy "Clipboard copied to '$SEND'"
# Error
else
    dunstctl close # mako
    notify-send -u critical -i dialog-error "Failed to copy clipboard to '$SEND'"
fi
