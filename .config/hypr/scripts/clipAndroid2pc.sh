#!/bin/bash
SEND="rodhfr@wings"
PORT="22"
# Annoucing
termux-notification --title "Clipboard Alert" --content "The clipboard content is being sent." --priority high --id clipboard_alert
# Try
CLIPBOARD=$(termux-clipboard-get)
if echo "$CLIPBOARD" | ssh -p "$PORT" "$SEND" "env WAYLAND_DISPLAY='wayland-1' wl-copy > /dev/null 2>&1"; then
    termux-notification-remove clipboard_alert
    termux-toast "Clipboard conten copied!"
# Error
else
    termux-notification-remove clipboard_alert
    termux-notification --title "Clipboard Alert" --content "The clipboard copy failed." --priority high --id clipboard_alert_failed
fi
