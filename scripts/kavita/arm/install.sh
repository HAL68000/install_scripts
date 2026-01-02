#!/data/data/com.termux/files/usr/bin/bash
# Created: 2026-01-02T00:00:00Z
set -euo pipefail

# Marker directory for progress/status (override with MARKER_DIR env if needed)
MARKER_DIR="${MARKER_DIR:-$PREFIX/var/lib/kavita}"
mkdir -p "$MARKER_DIR"
progress() { echo "$1" > "$MARKER_DIR/progress"; }
status() { echo "$1" > "$MARKER_DIR/status"; }

progress 0
status "[kavita] starting"

# Check if Kavita is already installed
if [ -f "$HOME/Kavita/Kavita" ]; then
  echo "[kavita-bootstrap] Kavita is already installed at $HOME/Kavita"
  status "[kavita] completed"
  progress 100
  exit 0
fi

echo "[kavita-bootstrap] Kavita not found, starting installation..."

status "[kavita] upgrading packages"
pkg upgrade -y --option Dpkg::Options::="--force-confnew"
progress 10

status "[kavita] installing dependencies"
pkg install -y curl jq tar
progress 20

status "[kavita] fetching latest release"
LATEST_URL=$(curl -s https://api.github.com/repos/Kareadita/Kavita/releases/latest | jq -r '.assets[] | select(.name | contains("kavita-linux-arm.tar.gz")) | .browser_download_url')

if [ -z "$LATEST_URL" ]; then
  echo "[kavita-bootstrap] ERROR: Could not find kavita-linux-arm.tar.gz in latest release"
  status "[kavita] failed"
  exit 1
fi

echo "[kavita-bootstrap] Downloading from: $LATEST_URL"
progress 30

status "[kavita] downloading Kavita"
cd "$HOME"
curl -L -o kavita-linux-arm.tar.gz "$LATEST_URL"
progress 60

status "[kavita] extracting archive"
tar -xzf kavita-linux-arm.tar.gz
progress 80

status "[kavita] setting permissions"
chmod +x "$HOME/Kavita/Kavita"
progress 90

status "[kavita] cleaning up"
rm -f kavita-linux-arm.tar.gz
progress 95

echo "[kavita-bootstrap] Installation completed!"
echo "[kavita-bootstrap] Kavita installed at $HOME/Kavita"
status "[kavita] completed"
progress 100
