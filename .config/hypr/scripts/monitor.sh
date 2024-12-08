#!/bin/bash
# Alternate between monitor modes (single screen and double screen) based on HDMI connection status

switch_file="monitor_switch"
monitor_string="HDMI-A-1"
edp_monitor="eDP-1"

# Initialize the switch file if it doesn't exist
if [ ! -f "$switch_file" ]; then
    echo "0" > "$switch_file"
fi

while true; do
    switch_value=$(<"$switch_file")  # Using direct redirection for safe reading

    echo "Running... (switch value: $switch_value)"

    # Check if HDMI is connected
    if hyprctl monitors all | grep -q "$monitor_string"; then
        # HDMI is connected, so disable the notebook screen (eDP-1)
        if [[ "$switch_value" == "0" ]]; then
            echo "HDMI connected. Disabling eDP-1 (notebook screen)."
            hyprctl keyword monitor $edp_monitor, disable
            # Update the switch file to reflect the double-screen mode
            echo "1" > "$switch_file"
        fi
    else
        # HDMI is disconnected, so enable the notebook screen (eDP-1)
        if [[ "$switch_value" == "1" ]]; then
            echo "HDMI disconnected. Enabling eDP-1 (notebook screen)."
            hyprctl keyword monitor $edp_monitor, enable
            # Update the switch file to reflect the single-screen mode
            echo "0" > "$switch_file"
        fi
    fi

    # Sleep for a short period before checking again (to prevent high CPU usage)
    sleep 5
done

