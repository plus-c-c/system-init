#!/bin/bash
# Debug adapters installation script for DAP (Debug Adapter Protocol)

set -e

echo "Installing debug adapters for DAP..."

# Create debug adapters directory
mkdir -p ~/.emacs.d/debug-adapters

# 1. Install js-debug (TypeScript/JavaScript)
echo "=== Installing js-debug ==="
JS_DEBUG_VERSION=$(curl -sL https://api.github.com/repos/microsoft/vscode-js-debug/releases/latest | grep -o '"tag_name": "[^"]*"' | cut -d'"' -f4)
if [ ! -z "$JS_DEBUG_VERSION" ]; then
    echo "Downloading js-debug $JS_DEBUG_VERSION..."
    curl -sL "https://github.com/microsoft/vscode-js-debug/releases/download/$JS_DEBUG_VERSION/js-debug-dap-$JS_DEBUG_VERSION.tar.gz" -o /tmp/js-debug-dap.tar.gz
    tar -xzf /tmp/js-debug-dap.tar.gz -C ~/.emacs.d/debug-adapters/
    rm /tmp/js-debug-dap.tar.gz
    echo "js-debug installed successfully"
else
    echo "Failed to get js-debug version"
fi

# 2. Install bash-debug (Bash/Shell)
echo "=== Installing bash-debug ==="
curl -sL -o /tmp/bash-debug.vsix "https://github.com/rogalmic/vscode-bash-debug/releases/download/v0.3.7/bash-debug-0.3.7.vsix"
if [ -f /tmp/bash-debug.vsix ]; then
    mkdir -p ~/.emacs.d/debug-adapters/bash-debug
    unzip -q /tmp/bash-debug.vsix -d ~/.emacs.d/debug-adapters/bash-debug/
    rm /tmp/bash-debug.vsix
    echo "bash-debug installed successfully"
else
    echo "Failed to download bash-debug"
fi

# 3. Install java-debug (Java)
echo "=== Installing java-debug ==="
yay -S --noconfirm java-debug 2>/dev/null || echo "java-debug installation failed (may already be installed)"

# 4. Configure JDTLS with debug plugin
echo "=== Configuring JDTLS with debug plugin ==="
JAVA_DEBUG_PLUGIN="/usr/share/java-debug/com.microsoft.java.debug.plugin.jar"
if [ -f "$JAVA_DEBUG_PLUGIN" ]; then
    # Update lsp-bridge jdtls.json with debug plugin
    JDTLS_CONFIG="$HOME/.emacs.d/site-lisp/lsp-bridge/langserver/jdtls.json"
    if [ -f "$JDTLS_CONFIG" ]; then
        # Add bundles to initializationOptions if not exists
        if ! grep -q '"bundles"' "$JDTLS_CONFIG"; then
            # Create a temporary file with the bundles added
            python3 << EOF
import json
with open('$JDTLS_CONFIG', 'r') as f:
    config = json.load(f)
if 'initializationOptions' not in config:
    config['initializationOptions'] = {}
config['initializationOptions']['bundles'] = ['$JAVA_DEBUG_PLUGIN']
with open('$JDTLS_CONFIG', 'w') as f:
    json.dump(config, f, indent=2)
EOF
            echo "Added debug plugin to JDTLS configuration"
        fi
    fi
fi

# 5. Install debugpy (Python)
echo "=== Installing debugpy ==="
pip install debugpy 2>/dev/null || pip3 install debugpy 2>/dev/null || echo "debugpy installation failed"

echo "=== Debug adapters installation complete ==="
echo "Installed adapters:"
ls -la ~/.emacs.d/debug-adapters/
