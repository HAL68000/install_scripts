#!/data/data/com.termux/files/usr/bin/bash
# Created: 2026-01-02T00:00:00Z
set -euo pipefail

echo "[syncthing-post-install] Running post-installation tasks..."

# Verify installation
if command -v syncthing >/dev/null 2>&1; then
  echo "[syncthing-post-install] Syncthing installed successfully"
  SYNCTHING_VERSION=$(syncthing --version | head -n1)
  echo "[syncthing-post-install] Syncthing version: $SYNCTHING_VERSION"
  echo "[syncthing-post-install] Web UI will be available at http://127.0.0.1:8384"
else
  echo "[syncthing-post-install] ERROR: Syncthing not found!"
  exit 1
fi

echo "[syncthing-post-install] Post-installation completed!"
