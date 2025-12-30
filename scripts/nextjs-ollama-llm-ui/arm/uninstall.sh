#!/data/data/com.termux/files/usr/bin/bash

echo "[nextjs-ollama-llm-ui-uninstall] Starting uninstallation..."

# Safe runner to ignore non-critical errors
run_safe() {
    "$@" >/dev/null 2>&1 || true
}

INSTALL_DIR="$HOME/nextjs-ollama-llm-ui"

# 1. Stop any running dev server
echo "[nextjs-ollama-llm-ui-uninstall] Stopping running processes..."
run_safe pkill -f "npm run dev"
run_safe pkill -f "next dev"

# 2. Remove installation directory
if [ -d "$INSTALL_DIR" ]; then
    echo "[nextjs-ollama-llm-ui-uninstall] Removing installation directory..."
    run_safe rm -rf "$INSTALL_DIR"
fi

# 3. Remove marker directory
echo "[nextjs-ollama-llm-ui-uninstall] Cleaning marker directory..."
run_safe rm -rf "$PREFIX/var/lib/nextjs-ollama-llm-ui"

# 4. Clean npm cache
echo "[nextjs-ollama-llm-ui-uninstall] Cleaning npm cache..."
run_safe npm cache clean --force

# Verify
if [ ! -d "$INSTALL_DIR" ]; then
    echo "[nextjs-ollama-llm-ui-uninstall] Successfully removed."
else
    echo "[nextjs-ollama-llm-ui-uninstall] Warning: May still be partially installed."
fi

echo "[nextjs-ollama-llm-ui-uninstall] Uninstallation completed!"
