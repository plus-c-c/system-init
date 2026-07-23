#!/bin/bash
app=$(tofi-drun)
if [  $app = "/usr/bin/chromium" ]; then
    args="--password-store=gnome-libsecret --no-proxy-server"
fi
if [  $app = "/usr/bin/google-chrome-stable" ]; then
    args="--password-store=gnome-libsecret --no-proxy-server"
fi
if [ $app = "obs" ]; then
    sudo modprobe v4l2loopback exclusive_caps=1 card_label="OBS Virtual Camera"
fi
hyprctl dispatch -- exec $app $args
