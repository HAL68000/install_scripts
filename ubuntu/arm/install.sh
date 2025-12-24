#!/data/data/com.termux/files/usr/bin/bash
# Created: 2025-12-23T00:00:00Z
set -euo pipefail

# Marker directory for progress/status (override with MARKER_DIR env if needed)
MARKER_DIR="${MARKER_DIR:-$PREFIX/var/lib/ubuntu}"
mkdir -p "$MARKER_DIR"
progress() { echo "$1" > "$MARKER_DIR/progress"; }
status() { echo "$1" > "$MARKER_DIR/status"; }

progress 0
status "[ubuntu] starting"

echo "[ubuntu-bootstrap] Starting Ubuntu installation..."

status "[ubuntu] updating packages"
pkg update -y --option Dpkg::Options::="--force-confnew"
progress 20

status "[ubuntu] installing proot-distro"
pkg install -y proot-distro 
progress 50
status "[ubuntu] installing ubuntu distro"
echo "[ubuntu-bootstrap] Installing Ubuntu distro (this may take a few minutes)..."
if ! proot-distro list | grep -q "^ubuntu$"; then
  proot-distro install ubuntu < /dev/null || true
fi
progress 90

echo "[ubuntu-bootstrap] Installation completed!"
status "[ubuntu] completed"
progress 100