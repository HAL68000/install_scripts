#!/data/data/com.termux/files/usr/bin/bash
# Created: 2026-01-02T00:00:00Z
set -euo pipefail

MARKER_DIR="${MARKER_DIR:-$PREFIX/var/lib/kavita}"
progress() { mkdir -p "$MARKER_DIR" && echo "$1" > "$MARKER_DIR/progress"; }
status() { mkdir -p "$MARKER_DIR" && echo "$1" > "$MARKER_DIR/status"; }

progress 0
status "[kavita] uninstalling"

echo "[kavita-uninstall] Removing Kavita..."

if [ -d "$HOME/Kavita" ]; then
  rm -rf "$HOME/Kavita"
  echo "[kavita-uninstall] Kavita directory removed"
  progress 50
else
  echo "[kavita-uninstall] Kavita directory not found"
  progress 50
fi

# Clean up any leftover archives
if [ -f "$HOME/kavita-linux-arm64.tar.gz" ]; then
  rm -f "$HOME/kavita-linux-arm64.tar.gz"
  echo "[kavita-uninstall] Archive removed"
fi

# Clean up marker directory
if [ -d "$MARKER_DIR" ]; then
  rm -rf "$MARKER_DIR"
  echo "[kavita-uninstall] Marker directory cleaned"
fi

progress 100
status "[kavita] uninstalled"
echo "[kavita-uninstall] Uninstallation completed!"
