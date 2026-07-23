#!/bin/bash
# opencode.sh — Install opencode CLI, configure systemd user service, and setup config
set -euo pipefail

PORT=4096
SERVICE_DIR="$HOME/.config/systemd/user"
SERVICE_FILE="$SERVICE_DIR/opencode-server.service"
CONFIG_DIR="$HOME/.config/opencode"
CONFIG_FILE="$CONFIG_DIR/opencode.jsonc"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# --- Install opencode ---
sudo pacman -S --noconfirm --needed opencode

# --- Install LSP servers ---
echo "Installing LSP servers..."
sudo pacman -S --noconfirm --needed bash-language-server clang pyright typescript-language-server vscode-json-languageserver

# --- Create systemd user service ---
mkdir -p "$SERVICE_DIR"

cat > "$SERVICE_FILE" <<EOF
[Unit]
Description=OpenCode AI Server
After=network-online.target
Wants=network-online.target

[Service]
ExecStart=/usr/bin/opencode serve --port $PORT --hostname localhost
Restart=on-failure
RestartSec=5
Environment=HOME=$HOME
Environment=PATH=/usr/bin:$HOME/.local/bin:$HOME/.volta/bin:$HOME/.asdf/shims:$HOME/.bun/bin:$HOME/.nvm/current/bin:$HOME/.local/share/pnpm:/usr/local/bin:/bin

[Install]
WantedBy=default.target
EOF

# --- Enable lingering (required for user services at boot) ---
if ! loginctl show-user "$USER" 2>/dev/null | grep -q "Linger=yes"; then
    sudo loginctl enable-linger "$USER"
    echo "Enabled lingering for $USER"
fi

# --- Enable and start service ---
systemctl --user daemon-reload
systemctl --user enable opencode-server.service
systemctl --user restart opencode-server.service

# --- Install opencode.jsonc config ---
mkdir -p "$CONFIG_DIR"
if [ -f "$SCRIPT_DIR/opencode.jsonc" ]; then
    cp "$SCRIPT_DIR/opencode.jsonc" "$CONFIG_FILE"
    echo "Installed opencode.jsonc to $CONFIG_DIR"
fi

echo "opencode server: enabled and running on port $PORT"
echo "  status: systemctl --user status opencode-server"
echo "  logs:   journalctl --user -u opencode-server -f"
