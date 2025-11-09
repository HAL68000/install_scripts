#!/data/data/com.termux/files/usr/bin/bash

echo "[n8n-uninstall] Starting uninstallation of n8n and dependencies..."

# Safe runner to ignore non-critical errors
run_safe() {
    "$@" >/dev/null 2>&1 || true
}

# 1. Uninstall global n8n
if command -v n8n >/dev/null 2>&1; then
    echo "[n8n-uninstall] Removing global n8n package..."
    run_safe npm uninstall -g n8n
else
    echo "[n8n-uninstall] n8n is not installed globally."
fi

# 2. Remove local sqlite3 module (if exists)
if [ -d "./node_modules/sqlite3" ]; then
    echo "[n8n-uninstall] Removing local sqlite3 module..."
    run_safe npm uninstall sqlite3
fi

# 3. Clean npm cache
echo "[n8n-uninstall] Cleaning npm cache..."
run_safe npm cache clean --force

# 4. Remove Termux packages installed by the bootstrap script
echo "[n8n-uninstall] Removing Termux packages (python, clang, make, git, binutils, nodejs-lts)..."
run_safe pkg uninstall -y python clang make git binutils nodejs-lts

# 5. Remove Python packages
echo "[n8n-uninstall] Uninstalling Python packages (setuptools)..."
run_safe pip uninstall -y setuptools

# 6. Remove n8n config/data directories
echo "[n8n-uninstall] Cleaning n8n configuration and cache directories..."
run_safe rm -rf ~/.n8n
run_safe rm -rf ~/.config/n8n
run_safe rm -rf ~/.npm
run_safe rm -rf ~/.cache
run_safe rm -rf /data/data/com.termux/files/usr/lib/node_modules/n8n

# 7. Unset environment variables
unset CXXFLAGS
unset GYP_DEFINES
unset N8N_SECURE_COOKIE

echo "[n8n-uninstall] Uninstallation completed successfully!"