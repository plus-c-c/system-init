#!/bin/bash
# Brightness control script
# Visual brightness 0-50%: hardware backlight at 0, adjust gamma
# Visual brightness 50-100%: adjust hardware backlight, gamma at 1.0

MIN=0
MAX=100
STATE_FILE=~/.config/hypr/scripts/.brightness_state

# Read current visual brightness from state file
read_brightness() {
    if [ -f "$STATE_FILE" ]; then
        cat "$STATE_FILE"
    else
        echo 50
    fi
}

# Ensure a persistent hyprsunset instance for flicker-free IPC gamma control
ensure_hyprsunset() {
    if ! pgrep -x hyprsunset > /dev/null; then
        hyprsunset > /dev/null 2>&1 &
        sleep 0.5
    fi
}

# Set gamma value (percent 30-100) via IPC - no restart, no flicker
set_gamma() {
    local gamma_percent=$1
    ensure_hyprsunset
    if [ "$gamma_percent" -ge 100 ]; then
        hyprctl hyprsunset identity > /dev/null 2>&1
    else
        hyprctl hyprsunset gamma "$gamma_percent" > /dev/null 2>&1
    fi
}

# Apply visual brightness (0-100)
apply_brightness() {
    local brightness=$1
    local gamma_percent

    if [ "$brightness" -le 50 ]; then
        # 0-50%: hardware at 0, gamma from 30% (dim) to 100% (bright)
        brightnessctl set 0% 2>/dev/null
        gamma_percent=$(awk "BEGIN{printf \"%d\", 30 + ($brightness / 50) * 70}")
        set_gamma "$gamma_percent"
    else
        # 50-100%: hardware from 0% to 100%, no gamma adjustment
        local hw=$(( (brightness - 50) * 2 ))
        brightnessctl set "${hw}%"
        set_gamma 100
    fi

    # Save state
    echo "$brightness" > "$STATE_FILE"

    # Notify waybar to refresh immediately (SIGRTMIN+3)
    pkill -RTMIN+3 waybar 2>/dev/null
}

current=$(read_brightness)

case "$1" in
    up)
        new=$((current + ${2:-5}))
        [ $new -gt $MAX ] && new=$MAX
        apply_brightness $new
        ;;
    down)
        new=$((current - ${2:-5}))
        [ $new -lt $MIN ] && new=$MIN
        apply_brightness $new
        ;;
    *)
        echo "Usage: $0 {up|down} [step]"
        exit 1
        ;;
esac
