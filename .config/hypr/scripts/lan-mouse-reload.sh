#!/bin/bash

if systemctl --user restart lan-mouse; then
    notify-send "Restarting lan-mouse service" "Check in 'systemctl --user status lan-mouse'"
fi

