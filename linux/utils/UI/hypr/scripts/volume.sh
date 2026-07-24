#!/bin/bash
# Volume control script with limits
# Min: 0%, Max: 150% (allows software amplification)

MIN=0
MAX=150

current=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')

case "$1" in
    up)
        new=$((current + ${2:-5}))
        [ $new -gt $MAX ] && new=$MAX
        wpctl set-volume @DEFAULT_AUDIO_SINK@ "${new}%"
        ;;
    down)
        new=$((current - ${2:-5}))
        [ $new -lt $MIN ] && new=$MIN
        wpctl set-volume @DEFAULT_AUDIO_SINK@ "${new}%"
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
    mic-mute)
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
        ;;
    *)
        echo "Usage: $0 {up|down|mute|mic-mute} [step]"
        exit 1
        ;;
esac
