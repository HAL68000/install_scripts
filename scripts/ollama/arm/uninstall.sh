#!/data/data/com.termux/files/usr/bin/bash

echo "[ollama-uninstall] Starting uninstallation of ollama and dependencies..."

# Safe runner to ignore non-critical errors
run_safe() {
    "$@" >/dev/null 2>&1 || true
}

# 1. Stop ollama service if running
echo "[ollama-uninstall] Stopping ollama service..."
run_safe pkill -f ollama
run_safe pkill -9 ollama

# 2. Uninstall ollama
if command -v ollama >/dev/null 2>&1; then
    echo "[ollama-uninstall] Removing ollama installation..."
    run_safe rm -f /data/data/com.termux/files/usr/bin/ollama
    run_safe rm -f /data/data/com.termux/files/usr/bin/ollama-serve
    run_safe npm uninstall -g ollama 2>/dev/null || true
fi

# 3. Remove ollama config/data directories
echo "[ollama-uninstall] Cleaning ollama configuration and data directories..."
run_safe rm -rf ~/.ollama
run_safe rm -rf ~/.config/ollama
run_safe rm -rf "$PREFIX/var/lib/ollama"
run_safe rm -rf ~/.local/share/ollama
run_safe rm -rf ~/.cache/ollama

# 4. Remove Termux packages installed by the bootstrap script
echo "[ollama-uninstall] Removing Termux packages (curl, git, build-essential)..."
run_safe pkg uninstall -y curl git build-essential

# 5. Clean package cache
echo "[ollama-uninstall] Cleaning package cache..."
run_safe rm -rf ~/.cache
run_safe rm -rf ~/.npm

# Verify
if ! command -v ollama >/dev/null 2>&1; then
    echo "[ollama-uninstall] Ollama successfully removed."
else
    echo "[ollama-uninstall] Warning: Ollama may still be partially installed."
fi

echo "[ollama-uninstall] Uninstallation completed!"
