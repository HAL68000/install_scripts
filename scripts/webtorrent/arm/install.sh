#!/data/data/com.termux/files/usr/bin/bash
# Created: 2026-01-01T00:00:00Z
set -euo pipefail

# Marker directory for progress/status (override with MARKER_DIR env if needed)
MARKER_DIR="${MARKER_DIR:-$PREFIX/var/lib/webtorrent}"
mkdir -p "$MARKER_DIR"
progress() { echo "$1" > "$MARKER_DIR/progress"; }
status() { echo "$1" > "$MARKER_DIR/status"; }

progress 0
status "[webtorrent] starting"

# Check if webtorrent is already installed
if command -v webtorrent >/dev/null 2>&1; then
  echo "[webtorrent-bootstrap] webtorrent already installed"
  webtorrent --version
  status "[webtorrent] completed"
  progress 100
  exit 0
fi

echo "[webtorrent-bootstrap] starting installation..."

status "[webtorrent] upgrading packages"
pkg upgrade -y --option Dpkg::Options::="--force-confnew"
progress 20

status "[webtorrent] installing nodejs"
pkg install -y nodejs
progress 50

status "[webtorrent] installing webtorrent"
npm install -g webtorrent-cli
progress 90

echo "[webtorrent-bootstrap] Installation completed!"
webtorrent --version
status "[webtorrent] completed"
progress 100
