#!/bin/bash
# HiDPI Configuration Script
# Usage: ./hidpi-setup.sh [scale_factor]
# Default scale factor: from var.sh

# Load global config
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../../var.sh"

# Override scale factor if provided
SCALE_FACTOR=${1:-$GLOBAL_SCALE_FACTOR}
BASE_DPI=${GLOBAL_BASE_DPI:-96}
CURSOR_BASE_SIZE=${GLOBAL_CURSOR_BASE_SIZE:-12}

# Calculate values
DPI=$((BASE_DPI * SCALE_FACTOR))
CURSOR_SIZE=$((CURSOR_BASE_SIZE * SCALE_FACTOR))

echo "=== HiDPI Configuration ==="
echo "Scale factor: ${SCALE_FACTOR}x"
echo "DPI: ${DPI}"
echo "Cursor size: ${CURSOR_SIZE}"

# 1. Hyprland cursor size
echo "[1/5] Updating Hyprland cursor size..."
sed -i "s/XCURSOR_SIZE,[0-9]*/XCURSOR_SIZE,${CURSOR_SIZE}/" ~/.config/hypr/hyprland.conf
sed -i "s/HYPRCURSOR_SIZE,[0-9]*/HYPRCURSOR_SIZE,${CURSOR_SIZE}/" ~/.config/hypr/hyprland.conf

# 2. Xft.dpi
echo "[2/5] Updating Xft.dpi..."
echo "Xft.dpi: ${DPI}" > ~/.Xresources
xrdb -merge ~/.Xresources 2>/dev/null

# 3. GTK cursor size
echo "[3/5] Updating GTK settings..."
mkdir -p ~/.config/gtk-3.0 ~/.config/gtk-4.0
for ver in 3.0 4.0; do
    if [ -d ~/.config/gtk-${ver} ]; then
        cat > ~/.config/gtk-${ver}/settings.ini << EOF
[Settings]
gtk-cursor-theme-size=${CURSOR_SIZE}
EOF
    fi
done

# 4. QT scale factor
echo "[4/5] Updating QT settings..."
if grep -q "QT_SCALE_FACTOR" ~/.config/hypr/hyprland.conf; then
    sed -i "s/QT_SCALE_FACTOR,[0-9]*/QT_SCALE_FACTOR,${SCALE_FACTOR}/" ~/.config/hypr/hyprland.conf
else
    sed -i "/env = XCURSOR_SIZE/a env = QT_SCALE_FACTOR,${SCALE_FACTOR}" ~/.config/hypr/hyprland.conf
fi

# 5. Waybar font size (proportional to scale)
echo "[5/5] Updating Waybar font size..."
WAYBAR_FONT_SIZE=$((18 * SCALE_FACTOR / 2))
sed -i "s/font-size: [0-9]*px/font-size: ${WAYBAR_FONT_SIZE}px/" ~/.config/waybar/style.css

echo ""
echo "=== Done ==="
echo "Please run: hyprctl reload"
