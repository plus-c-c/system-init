#!/bin/bash
# Emacs daemon 开机自启 + HiDPI 光标适配

echo "设置 Emacs daemon 开机自启..."

# 部署 systemd service override：设置 XCURSOR_SIZE=12
# 补偿 Xft.dpi=192 导致 GTK3 光标 2x 缩放（24×2=48→96px），仅影响 Emacs
OVERRIDE_DIR="$HOME/.config/systemd/user/emacs.service.d"
mkdir -p "$OVERRIDE_DIR"
cat > "$OVERRIDE_DIR/cursor.conf" <<'EOF'
[Service]
Environment=XCURSOR_SIZE=12
EOF
systemctl --user daemon-reload

# 启用 systemd 用户服务
systemctl --user enable emacs.service

# 启动服务（如果未运行）
if ! systemctl --user is-active --quiet emacs.service; then
    systemctl --user start emacs.service
    echo "已启动 Emacs daemon"
fi

echo "Emacs daemon 开机自启已配置"
