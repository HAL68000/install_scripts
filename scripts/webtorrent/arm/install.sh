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

# Check if webtorrent-desktop is already installed
if [ -d "$HOME/webtorrent-desktop" ]; then
  echo "[webtorrent-bootstrap] webtorrent-desktop already exists at $HOME/webtorrent-desktop"
  status "[webtorrent] completed"
  progress 100
  exit 0
fi

echo "[webtorrent-bootstrap] starting installation..."

status "[webtorrent] upgrading packages"
pkg upgrade -y --option Dpkg::Options::="--force-confnew"
progress 10

status "[webtorrent] installing git"
pkg install -y git
progress 30

status "[webtorrent] installing nodejs"
pkg install -y nodejs
progress 50

status "[webtorrent] cloning repository"
cd "$HOME"
git clone https://github.com/webtorrent/webtorrent-desktop.git
progress 70

status "[webtorrent] installing dependencies"
cd webtorrent-desktop
npm install
progress 90

echo "[webtorrent-bootstrap] Installation completed!"
status "[webtorrent] completed"
progress 100
