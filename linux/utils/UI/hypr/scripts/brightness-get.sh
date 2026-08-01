#!/bin/bash
# Display visual brightness for waybar (pure number output)
# Reads visual brightness from state file
STATE_FILE=~/.config/hypr/scripts/.brightness_state

# If state file doesn't exist, calculate from hardware
if [ ! -f "$STATE_FILE" ]; then
    hw=$(brightnessctl -m | awk -F, '{print $4}' | tr -d '%')
    if [ "$hw" -gt 0 ]; then
        brightness=50
    else
        brightness=0
    fi
else
    brightness=$(cat "$STATE_FILE")
fi

# Output pure number for waybar custom module with format-icons
printf '%s' "$brightness"
