#!/bin/bash
app=$(tofi-drun)
if [  $app = "/usr/bin/chromium" ]; then
    args="--password-store=gnome-libsecret"
else
    args=""
fi
if [ $app = "obs" ]; then
    sudo modprobe v4l2loopback exclusive_caps=1 card_label="OBS Virtual Camera"
fi
if [ $app = "dingtalk" ]; then
    export QT_QPA_PLATFORM="xcb"
    export GDK_BACKEND="x11"
    export SDL_VIDEODRIVER="x11"
    export CLUTTER_BACKEND="x11"

    # 2. 关键：清除所有Wayland会话标识
    # 这些是你的环境里存在的，必须清除
    unset XDG_BACKEND
    unset WAYLAND_DISPLAY
    unset XDG_SESSION_TYPE
    unset XDG_CURRENT_DESKTOP
    unset XDG_SESSION_DESKTOP
    unset DESKTOP_SESSION
    # 清除可能导致后端检测冲突的变量
    unset XDG_BACKEND
    unset MOZ_ENABLE_WAYLAND

    # 3. 为Electron/Chromium（钉钉基础）设置明确标志
    export ELECTRON_OZONE_PLATFORM_HINT="x11"
fi
hyprctl dispatch -- exec $app $args
