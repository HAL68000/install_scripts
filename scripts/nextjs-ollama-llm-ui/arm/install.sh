#!/data/data/com.termux/files/usr/bin/bash
# Created: 2025-12-30T00:00:00Z
set -euo pipefail

# Marker directory for progress/status (override with MARKER_DIR env if needed)
MARKER_DIR="${MARKER_DIR:-$PREFIX/var/lib/nextjs-ollama-llm-ui}"
mkdir -p "$MARKER_DIR"
progress() { echo "$1" > "$MARKER_DIR/progress"; }
status() { echo "$1" > "$MARKER_DIR/status"; }

progress 0
status "[nextjs-ollama-llm-ui] starting"

# Installation directory
INSTALL_DIR="$HOME/nextjs-ollama-llm-ui"

# If already installed, finish immediately
if [ -d "$INSTALL_DIR" ] && [ -f "$INSTALL_DIR/package.json" ]; then
  echo "[nextjs-ollama-llm-ui] already installed at $INSTALL_DIR"
  status "[nextjs-ollama-llm-ui] completed"
  progress 100
  exit 0
fi

echo "[nextjs-ollama-llm-ui] starting installation..."

status "[nextjs-ollama-llm-ui] upgrading packages"
pkg upgrade -y --option Dpkg::Options::="--force-confnew"
progress 10

status "[nextjs-ollama-llm-ui] installing dependencies"
pkg install -y git nodejs
progress 20

status "[nextjs-ollama-llm-ui] cloning repository"
cd "$HOME"
git clone https://github.com/jakobhoeg/nextjs-ollama-llm-ui
progress 40

status "[nextjs-ollama-llm-ui] configuring environment"
cd "$INSTALL_DIR"
mv .example.env .env
progress 50

status "[nextjs-ollama-llm-ui] installing npm packages"
npm install
progress 90

echo "[nextjs-ollama-llm-ui] Installation completed!"
status "[nextjs-ollama-llm-ui] completed"
progress 100
