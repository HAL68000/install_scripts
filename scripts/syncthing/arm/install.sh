#!/data/data/com.termux/files/usr/bin/bash
# Created: 2026-01-02T00:00:00Z
set -euo pipefail

# Marker directory for progress/status (override with MARKER_DIR env if needed)
MARKER_DIR="${MARKER_DIR:-$PREFIX/var/lib/syncthing}"
mkdir -p "$MARKER_DIR"
progress() { echo "$1" > "$MARKER_DIR/progress"; }
status() { echo "$1" > "$MARKER_DIR/status"; }

progress 0
status "[syncthing] starting"

# Check if syncthing is already installed
if command -v syncthing >/dev/null 2>&1; then
  echo "[syncthing-bootstrap] syncthing is already installed (version: $(syncthing --version | head -n1))"
  status "[syncthing] completed"
  progress 100
  exit 0
fi

echo "[syncthing-bootstrap] syncthing not found, starting installation..."

status "[syncthing] upgrading packages"
pkg update -y
progress 30

status "[syncthing] installing syncthing"
pkg install -y syncthing
progress 90

echo "[syncthing-bootstrap] Installation completed!"
syncthing --version | head -n1
status "[syncthing] completed"
progress 100
