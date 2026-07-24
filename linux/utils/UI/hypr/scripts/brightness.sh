#!/bin/bash
# Brightness control script with gamma sync
# Min: 1%, Max: 100%

MIN=0
MAX=100

# Calculate gamma based on brightness level (lower brightness = lower gamma)
# Uses sqrt curve for slower gamma decrease
calc_gamma() {
    local brightness=$1
    # gamma range: 0.5 (dim) to 1.0 (bright)
    # sqrt curve: gamma decreases slower at low brightness
    echo "scale=2; 0.5 + 0.5 * sqrt($brightness / 100)" | bc
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
