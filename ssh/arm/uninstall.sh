#!/data/data/com.termux/files/usr/bin/bash
echo "[ssh-uninstall] Starting SSH uninstallation..."

run_safe() {
    "$@" >/dev/null 2>&1 || true
}

# Clear potential apt locks first
echo "[ssh-uninstall] Checking for apt locks..."
run_safe rm -f /data/data/com.termux/files/usr/var/lib/dpkg/lock
run_safe rm -f /data/data/com.termux/files/usr/var/lib/apt/lists/lock
run_safe rm -f /data/data/com.termux/files/usr/var/cache/apt/archives/lock
run_safe dpkg --configure -a

# Stop SSH server
echo "[ssh-uninstall] Stopping SSH server..."
run_safe pkill -9 sshd

# Uninstall OpenSSH safely
echo "[ssh-uninstall] Uninstalling OpenSSH package..."
run_safe env DEBIAN_FRONTEND=noninteractive apt-get purge -y openssh

# Remove configuration and keys
echo "[ssh-uninstall] Removing SSH configuration and keys..."
run_safe rm -rf ~/.ssh
run_safe rm -f /data/data/com.termux/files/usr/etc/ssh/sshd_config
run_safe rm -rf /data/data/com.termux/files/usr/var/run/sshd
run_safe rm -rf /data/data/com.termux/files/usr/var/log/sshd*

# Cleanup
echo "[ssh-uninstall] Cleaning SSH-related cache..."
run_safe rm -rf ~/.cache
run_safe rm -rf ~/.local/share/ssh

# Verify
if ! command -v sshd >/dev/null 2>&1; then
    echo "[ssh-uninstall] SSH successfully removed."
else
    echo "[ssh-uninstall] Warning: SSH may still be partially installed."
fi

echo "[ssh-uninstall] Uninstallation completed!"
