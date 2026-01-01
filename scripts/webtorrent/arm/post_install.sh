#!/data/data/com.termux/files/usr/bin/bash
# Created: 2026-01-01T00:00:00Z
set -euo pipefail

echo "[webtorrent-post-install] Running post-installation tasks..."

# Verify installation
if [ -d "$HOME/webtorrent-desktop" ]; then
  echo "[webtorrent-post-install] WebTorrent Desktop installed successfully at $HOME/webtorrent-desktop"
  echo "[webtorrent-post-install] To start WebTorrent, run: cd ~/webtorrent-desktop && npm start"
else
  echo "[webtorrent-post-install] ERROR: WebTorrent Desktop directory not found!"
  exit 1
fi

# Check Node.js version
if command -v node >/dev/null 2>&1; then
  NODE_VERSION=$(node --version)
  echo "[webtorrent-post-install] Node.js version: $NODE_VERSION"
else
  echo "[webtorrent-post-install] WARNING: Node.js not found!"
fi

# Check npm version
if command -v npm >/dev/null 2>&1; then
  NPM_VERSION=$(npm --version)
  echo "[webtorrent-post-install] npm version: $NPM_VERSION"
else
  echo "[webtorrent-post-install] WARNING: npm not found!"
fi

echo "[webtorrent-post-install] Post-installation completed!"
