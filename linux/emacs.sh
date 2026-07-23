#!/bin/bash
# Emacs daemon 开机自启

echo "设置 Emacs daemon 开机自启..."

# 启用 systemd 用户服务
systemctl --user enable emacs.service

# 启动服务（如果未运行）
if ! systemctl --user is-active --quiet emacs.service; then
    systemctl --user start emacs.service
    echo "已启动 Emacs daemon"
fi

echo "Emacs daemon 开机自启已配置"
