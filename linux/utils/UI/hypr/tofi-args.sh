#!/bin/bash
app=$(tofi-drun)
if [  $app = "/usr/bin/chromium" ]; then
    args="--password-store=gnome-libsecret"
else
    args=""
fi
hyprctl dispatch -- exec $app $args
