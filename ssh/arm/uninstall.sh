#!/data/data/com.termux/files/usr/bin/bash

echo "[ssh-uninstall] Starting SSH uninstallation..."

# Helper to safely run commands without breaking the script
run_safe() {
    "$@" >/dev/null 2>&1 || true
}

# 1. Stop SSH server if it's running
echo "[ssh-uninstall] Stopping SSH server..."
run_safe pkill sshd

# 2. Remove OpenSSH package
echo "[ssh-uninstall] Uninstalling OpenSSH package..."
run_safe pkg uninstall -y openssh

# 3. Remove SSH configuration and key files
echo "[ssh-uninstall] Removing SSH configuration and keys..."
run_safe rm -rf ~/.ssh
run_safe rm -rf ~/.ssh/
run_safe rm -f /data/data/com.termux/files/usr/etc/ssh/sshd_config
run_safe rm -rf /data/data/com.termux/files/usr/var/run/sshd
run_safe rm -rf /data/data/com.termux/files/usr/var/log/sshd*

# 4. Clear any leftover cache or related files
echo "[ssh-uninstall] Cleaning SSH-related cache..."
run_safe rm -rf ~/.cache
run_safe rm -rf ~/.local/share/ssh

# 5. Confirm removal
if ! command -v sshd >/dev/null 2>&1; then
    echo "[ssh-uninstall] SSH successfully removed."
else
    echo "[ssh-uninstall] Warning: SSH may still be partially installed."
fi

echo "[ssh-uninstall] Uninstallation completed!"
