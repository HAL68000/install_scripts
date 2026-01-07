#!/data/data/com.termux/files/usr/bin/bash
# Created: 2025-12-22T00:00:00Z
set -euo pipefail

# Marker directory for progress/status (override with MARKER_DIR env if needed)
MARKER_DIR="${MARKER_DIR:-$PREFIX/var/lib/ollama}"
mkdir -p "$MARKER_DIR"
progress() { echo "$1" > "$MARKER_DIR/progress"; }
status() { echo "$1" > "$MARKER_DIR/status"; }

progress 0
status "[ollama] starting"

# If ollama is already installed, finish immediately
if command -v ollama >/dev/null 2>&1; then
  echo "[ollama-bootstrap] ollama is already installed (version: $(ollama --version))"
  status "[ollama] completed"
  progress 100
  exit 0
fi

echo "[ollama-bootstrap] ollama not found, starting installation..."

status "[ollama] upgrading packages"
pkg upgrade -y --option Dpkg::Options::="--force-confnew"
progress 10

status "[ollama] installing tools"
pkg install -y curl git build-essential 
progress 30

status "[ollama] installing ubuntu and ollama"
proot-distro install ubuntu && proot-distro exec ubuntu -- bash -lc "apt update && apt upgrade -y && curl -fsSL https://ollama.com/install.sh | sh" && mkdir -p "$PREFIX/var/lib/ollama"
progress 80


echo "[ollama-bootstrap] Installation completed!"
status "[ollama] completed"
progress 100
