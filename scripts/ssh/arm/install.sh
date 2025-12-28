#!/data/data/com.termux/files/usr/bin/bash
# Created: 2025-12-23T00:00:00Z
set -euo pipefail

# Marker directory for progress/status (override with MARKER_DIR env if needed)
MARKER_DIR="${MARKER_DIR:-$PREFIX/var/lib/ssh}"
mkdir -p "$MARKER_DIR"
progress() { echo "$1" > "$MARKER_DIR/progress"; }
status() { echo "$1" > "$MARKER_DIR/status"; }

progress 0
status "[ssh] starting"

echo "[ssh-setup] Resetting Termux mirrors and updating packages..."

status "[ssh] upgrading packages"
pkg upgrade -y --option Dpkg::Options::="--force-confnew"
progress 20

status "[ssh] reinstalling essential libraries"
echo "[ssh-setup] Reinstalling essential libraries..."
pkg install -y proot tar wget curl apt liblz4 termux-auth
progress 40

status "[ssh] installing openssh"
echo "[ssh-setup] Installing OpenSSH, expect, and termux-auth (auto-confirming config changes)..."

pkg install -y --option Dpkg::Options::="--force-confnew" openssh expect
progress 60

# Generate SSH keys if missing
status "[ssh] generating ssh keys"
if [ ! -f ~/.ssh/id_rsa ]; then
    echo "[ssh-setup] Generating new SSH key pair..."
    mkdir -p ~/.ssh
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N "" >/dev/null 2>&1 || true
else
    echo "[ssh-setup] SSH key pair already exists, skipping generation."
fi
progress 80

status "[ssh] setting password"
echo -e "123changeme\n123changeme" | passwd

echo "[ssh-setup] Password has been set successfully."
progress 90

echo "[ssh-bootstrap] Installation completed!"
status "[ssh] completed"
progress 100