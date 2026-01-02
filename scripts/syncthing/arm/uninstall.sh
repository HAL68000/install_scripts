#!/data/data/com.termux/files/usr/bin/bash
# Created: 2026-01-02T00:00:00Z
set -euo pipefail

MARKER_DIR="${MARKER_DIR:-$PREFIX/var/lib/syncthing}"
progress() { mkdir -p "$MARKER_DIR" && echo "$1" > "$MARKER_DIR/progress"; }
status() { mkdir -p "$MARKER_DIR" && echo "$1" > "$MARKER_DIR/status"; }

progress 0
status "[syncthing] uninstalling"

echo "[syncthing-uninstall] Removing syncthing..."

if command -v syncthing >/dev/null 2>&1; then
  pkg uninstall -y syncthing
  echo "[syncthing-uninstall] syncthing removed"
  progress 50
else
  echo "[syncthing-uninstall] syncthing not found"
  progress 50
fi

# Clean up marker directory
if [ -d "$MARKER_DIR" ]; then
  rm -rf "$MARKER_DIR"
  echo "[syncthing-uninstall] Marker directory cleaned"
fi

progress 100
status "[syncthing] uninstalled"
echo "[syncthing-uninstall] Uninstallation completed!"
