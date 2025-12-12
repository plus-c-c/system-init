#!/bin/bash
app=$(tofi-drun)
if [  $app = "/usr/bin/chromium" ]; then
    args="--password-store=gnome-libsecret"
else
    args=""
fi
if [ $app = "vosviewer" ]; then
    export JAVA_TOOL_OPTIONS="-Dsun.java2d.uiScale=2"
fi
hyprctl dispatch -- exec $app $args
