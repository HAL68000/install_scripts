#!/data/data/com.termux/files/usr/bin/bash
# Created: 2026-01-01T00:00:00Z
set -euo pipefail

echo "[webtorrent-post-install] Running post-installation tasks..."

# Verify installation
if command -v webtorrent >/dev/null 2>&1; then
  echo "[webtorrent-post-install] WebTorrent CLI installed successfully"
  WEBTORRENT_VERSION=$(webtorrent --version)
  echo "[webtorrent-post-install] WebTorrent version: $WEBTORRENT_VERSION"
  echo "[webtorrent-post-install] Usage: webtorrent [magnet-link or torrent-file]"
else
  echo "[webtorrent-post-install] ERROR: WebTorrent not found!"
  exit 1
fi

# Check Node.js version
if command -v node >/dev/null 2>&1; then
  NODE_VERSION=$(node --version)
  echo "[webtorrent-post-install] Node.js version: $NODE_VERSION"
else
  echo "[webtorrent-post-install] WARNING: Node.js not found!"
fi

echo "[webtorrent-post-install] Post-installation completed!"
