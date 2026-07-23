#!/bin/bash
# elisp-lsp.sh — Install custom Elisp LSP server for opencode
set -euo pipefail

EMACS_DIR="$HOME/.emacs.d"
LSP_DIR="$EMACS_DIR/site-lisp/elisp-lsp"
WRAPPER="/usr/local/bin/elisp-lsp-server"

# --- Create directories ---
mkdir -p "$LSP_DIR"

# --- Copy LSP server files ---
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

# Copy from site-lisp if already present, otherwise from system-init
if [ -d "$REPO_DIR/site-lisp/elisp-lsp" ]; then
    cp "$REPO_DIR/site-lisp/elisp-lsp/"*.el "$LSP_DIR/"
    cp "$REPO_DIR/site-lisp/elisp-lsp/"*.py "$LSP_DIR/"
fi

# --- Create wrapper script ---
cat > "$WRAPPER" << 'WRAPPER'
#!/bin/bash
# elisp-lsp-server: LSP server for Emacs Lisp via Emacs daemon
exec python3 "$HOME/.emacs.d/site-lisp/elisp-lsp/elisp-lsp-server.py"
WRAPPER
sudo chmod +x "$WRAPPER"

# --- Verify ---
if [ -f "$LSP_DIR/elisp-lsp-server.py" ] && [ -f "$WRAPPER" ]; then
    echo "elisp-lsp-server installed: $WRAPPER"
    echo "LSP files in: $LSP_DIR"
else
    echo "Error: installation failed"
    exit 1
fi
