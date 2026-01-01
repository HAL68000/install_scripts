#!/data/data/com.termux/files/usr/bin/bash
# Created: 2026-01-01T00:00:00Z
set -euo pipefail

MARKER_DIR="${MARKER_DIR:-$PREFIX/var/lib/webtorrent}"
progress() { mkdir -p "$MARKER_DIR" && echo "$1" > "$MARKER_DIR/progress"; }
status() { mkdir -p "$MARKER_DIR" && echo "$1" > "$MARKER_DIR/status"; }

progress 0
status "[webtorrent] uninstalling"

echo "[webtorrent-uninstall] Removing webtorrent..."

if command -v webtorrent >/dev/null 2>&1; then
  npm uninstall -g webtorrent-cli
  echo "[webtorrent-uninstall] webtorrent-cli removed"
  progress 50
else
  echo "[webtorrent-uninstall] webtorrent not found"
  progress 50
fi

# Clean up marker directory
if [ -d "$MARKER_DIR" ]; then
  rm -rf "$MARKER_DIR"
  echo "[webtorrent-uninstall] Marker directory cleaned"
fi

progress 100
status "[webtorrent] uninstalled"
echo "[webtorrent-uninstall] Uninstallation completed!"
