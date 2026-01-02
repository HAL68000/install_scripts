#!/data/data/com.termux/files/usr/bin/bash
# Created: 2026-01-02T00:00:00Z
set -euo pipefail

echo "[kavita-post-install] Running post-installation tasks..."

# Verify installation
if [ -f "$HOME/Kavita/Kavita" ] && [ -x "$HOME/Kavita/Kavita" ]; then
  echo "[kavita-post-install] Kavita installed successfully at $HOME/Kavita"
  echo "[kavita-post-install] Kavita executable is ready"
  echo "[kavita-post-install] Web UI will be available at http://localhost:5000"
else
  echo "[kavita-post-install] ERROR: Kavita executable not found or not executable!"
  exit 1
fi

echo "[kavita-post-install] Post-installation completed!"
