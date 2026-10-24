#!/bin/bash
# desktop-defaults.sh — 桌面默认项（Thunar / MIME / kitty）
#
# 作用：
#   1. 为 .mid/.midi 与 .wav/.wave 安装并设置默认打开方式
#   2. 设置 Thunar 的 "Open Terminal Here" 默认终端为 kitty
#   3. 修复 kitty 在 Hyprland 上恢复 maximized/fullscreen 窗口状态的问题
#
# 可重复执行；不会覆盖 helpers.rc 中的其它条目。
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
APPS_DIR="$DATA_HOME/applications"

mkdir -p "$APPS_DIR" "$CONFIG_HOME/xfce4" "$CONFIG_HOME/kitty"

# ------------------------------------------------------------
# 1. 安装 .desktop 文件
# ------------------------------------------------------------
install -m 0644 "$SCRIPT_DIR/utils/UI/applications/midi-fluidsynth.desktop" "$APPS_DIR/"
install -m 0644 "$SCRIPT_DIR/utils/UI/applications/wav-totem.desktop" "$APPS_DIR/"

# ------------------------------------------------------------
# 2. 设置 MIME 默认应用（同时写 config 与 data 两处，Thunar/GIO 都能读到）
# ------------------------------------------------------------
python3 - "$CONFIG_HOME/mimeapps.list" "$APPS_DIR/mimeapps.list" <<'PY'
import os
import sys

mapping = {
    "audio/midi": "midi-fluidsynth.desktop",
    "audio/x-midi": "midi-fluidsynth.desktop",
    "audio/wav": "wav-totem.desktop",
    "audio/x-wav": "wav-totem.desktop",
    "audio/wave": "wav-totem.desktop",
}

for path in sys.argv[1:]:
    os.makedirs(os.path.dirname(path), exist_ok=True)
    lines = []
    if os.path.exists(path):
        with open(path, encoding="utf-8") as f:
            lines = f.read().splitlines()

    out = []
    in_defaults = False
    inserted = False
    for line in lines:
        stripped = line.strip()
        if stripped.startswith("[") and stripped.endswith("]"):
            in_defaults = stripped == "[Default Applications]"
            out.append(line)
            if in_defaults:
                out.extend(f"{k}={v}" for k, v in mapping.items())
                inserted = True
            continue
        if in_defaults:
            key = line.split("=", 1)[0].strip()
            if key in mapping:
                continue
        out.append(line)

    if not inserted:
        if out and out[-1].strip():
            out.append("")
        out.append("[Default Applications]")
        out.extend(f"{k}={v}" for k, v in mapping.items())

    with open(path, "w", encoding="utf-8") as f:
        f.write("\n".join(out) + "\n")
PY

if command -v xdg-mime >/dev/null 2>&1; then
    xdg-mime default midi-fluidsynth.desktop audio/midi
    xdg-mime default midi-fluidsynth.desktop audio/x-midi
    xdg-mime default wav-totem.desktop audio/wav
    xdg-mime default wav-totem.desktop audio/x-wav
    xdg-mime default wav-totem.desktop audio/wave
fi

if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database "$APPS_DIR" || true
fi

# ------------------------------------------------------------
# 3. Thunar 默认终端：exo-open 读取 helpers.rc
# ------------------------------------------------------------
HELPERS="$CONFIG_HOME/xfce4/helpers.rc"
touch "$HELPERS"

set_rc_key() {
    local key="$1" value="$2" file="$3"
    if grep -q "^${key}=" "$file"; then
        sed -i "s|^${key}=.*|${key}=${value}|" "$file"
    else
        printf '%s=%s\n' "$key" "$value" >> "$file"
    fi
}

set_rc_key "TerminalEmulator" "kitty" "$HELPERS"
set_rc_key "TerminalEmulatorDismissed" "true" "$HELPERS"

# ------------------------------------------------------------
# 4. kitty：禁止恢复上次的 maximized/fullscreen 窗口状态
#    Hyprland 会把 kitty 缓存的 window-state=maximized 当成全屏，
#    导致新窗口覆盖其它窗口。这里同时清掉旧缓存。
# ------------------------------------------------------------
KITTY_CONF="$CONFIG_HOME/kitty/kitty.conf"
touch "$KITTY_CONF"
sed -i '/^# BEGIN system-init kitty window$/,/^# END system-init kitty window$/d' "$KITTY_CONF"
cat >> "$KITTY_CONF" <<'EOF'

# BEGIN system-init kitty window
# Avoid restoring a saved maximized/fullscreen window state on Hyprland.
remember_window_size no
remember_window_position no
initial_window_width 1000
initial_window_height 650
placement_strategy center
# END system-init kitty window
EOF
rm -f "$CACHE_HOME/kitty/main.json"

echo "desktop-defaults: done"
echo "  MIDI -> $APPS_DIR/midi-fluidsynth.desktop"
echo "  WAV  -> $APPS_DIR/wav-totem.desktop"
echo "  Thunar terminal -> kitty"
echo "  kitty window state cache cleared: $CACHE_HOME/kitty/main.json"
