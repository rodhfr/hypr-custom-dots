#!/bin/bash
# CLIENT TO SEND CLIPBOARD
SEND="u0_a300@helium"
PORT="8022"
# Annoucing
notify-send -i clipboard "Getting clipboard from '$SEND'..."
# Try:
if ssh -p "$PORT" "$SEND" "termux-clipboard-get" | wl-copy; then
    dunstctl close # mako
    notify-send -i edit-copy "Clipboard get from '$SEND'"
    ssh -p "$PORT" "$SEND" "termux-toast 'Clipboard content sent to remote!'"
# Error
else
    dunstctl close # mako
    notify-send -u critical -i dialog-error "Failed to get clipboard from '$SEND'"
    ssh -p "$PORT" "$SEND" "termux-toast 'Clipboard sent error"
fi
