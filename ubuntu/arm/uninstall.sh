#!/data/data/com.termux/files/usr/bin/bash

echo "[ubuntu-uninstall] Starting uninstallation of Ubuntu distro and proot-distro..."

# Safe runner to ignore non-critical errors
run_safe() {
    "$@" >/dev/null 2>&1 || true
}

# 1. Remove Ubuntu distro
if proot-distro list 2>/dev/null | grep -q ubuntu; then
    echo "[ubuntu-uninstall] Removing Ubuntu distro..."
    run_safe proot-distro remove ubuntu
else
    echo "[ubuntu-uninstall] Ubuntu distro is not installed."
fi

# 2. Uninstall proot-distro
echo "[ubuntu-uninstall] Removing proot-distro package..."
run_safe pkg uninstall -y proot-distro

# 3. Remove proot-distro config/data directories
echo "[ubuntu-uninstall] Cleaning proot-distro directories..."
run_safe rm -rf ~/.proot-distro
run_safe rm -rf "$PREFIX/var/lib/proot-distro"
run_safe rm -rf "$PREFIX/etc/proot-distro"

# 4. Clean package cache
echo "[ubuntu-uninstall] Cleaning package cache..."
run_safe rm -rf ~/.cache
run_safe pkg clean

# Verify
if ! command -v proot-distro >/dev/null 2>&1; then
    echo "[ubuntu-uninstall] Ubuntu distro and proot-distro successfully removed."
else
    echo "[ubuntu-uninstall] Warning: proot-distro may still be partially installed."
fi

echo "[ubuntu-uninstall] Uninstallation completed!"
