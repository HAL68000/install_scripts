#!/data/data/com.termux/files/usr/bin/bash
# Created: 2025-12-22T00:00:00Z
set -euo pipefail

# Marker directory for progress/status (override with MARKER_DIR env if needed)
MARKER_DIR="${MARKER_DIR:-$PREFIX/var/lib/ollama}"
mkdir -p "$MARKER_DIR"
progress() { echo "$1" > "$MARKER_DIR/progress"; }
status() { echo "$1" > "$MARKER_DIR/status"; }

status "[ollama] installing ubuntu"
bash proot-distro install ubuntu
progress 80
status "[ollama] installing ollama"
proot-distro exec ubuntu -- bash -lc "apt update && apt upgrade -y && curl -fsSL https://ollama.com/install.sh | sh" && mkdir -p "$PREFIX/var/lib/ollama
progress 90
echo "[ollama-bootstrap] Installation completed!"
status "[ollama] completed"
progress 100
