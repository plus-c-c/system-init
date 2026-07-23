#!/bin/bash
# Brightness control script with gamma sync
# Min: 1%, Max: 100%

MIN=0
MAX=100

# Calculate gamma based on brightness level (lower brightness = lower gamma)
calc_gamma() {
    local brightness=$1
    # gamma range: 0.4 (dim) to 1.0 (bright)
    echo "scale=2; 0.4 + ($brightness / 100) * 0.6" | bc
}

current=$(brightnessctl -m | awk -F, '{print $4}' | tr -d '%')

case "$1" in
    up)
        new=$((current + ${2:-5}))
        [ $new -gt $MAX ] && new=$MAX
        brightnessctl set "${new}%"
        ;;
    down)
        new=$((current - ${2:-5}))
        [ $new -lt $MIN ] && new=$MIN
        brightnessctl set "${new}%"
        ;;
    *)
        echo "Usage: $0 {up|down} [step]"
        exit 1
        ;;
esac

# Sync gamma with brightness
gamma=$(calc_gamma $new)
pkill wlsunset 2>/dev/null
wlsunset -g "$gamma" > /dev/null 2>&1 &
