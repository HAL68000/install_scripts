#!/data/data/com.termux/files/usr/bin/bash
# Created: 2025-12-18T23:55:40Z
set -euo pipefail

# Marker directory for progress/status (override with MARKER_DIR env if needed)
MARKER_DIR="${MARKER_DIR:-$PREFIX/var/lib/n8n}"
mkdir -p "$MARKER_DIR"
progress() { echo "$1" > "$MARKER_DIR/progress"; }
status() { echo "$1" > "$MARKER_DIR/status"; }

progress 0
status "[n8n] starting"

# If n8n is already installed, finish immediately
if command -v n8n >/dev/null 2>&1; then
  echo "[n8n-bootstrap] n8n is already installed (version: $(n8n --version))"
  status "[n8n] completed"
  progress 100
  exit 0
fi

echo "[n8n-bootstrap] n8n not found, starting installation..."

status "[n8n] upgrading packages"
pkg upgrade -y --option Dpkg::Options::="--force-confnew"
progress 10

status "[n8n] installing tools"
pkg install -y python clang make git binutils nodejs-lts
progress 30

status "[n8n] preparing environment"
pip install setuptools
progress 40
export CXXFLAGS="--std=c++17"
# Use empty default to avoid set -u error if ANDROID_NDK_HOME is unset
export GYP_DEFINES="android_ndk_path=${ANDROID_NDK_HOME:-}"
export N8N_SECURE_COOKIE=false

status "[n8n] installing node dependencies"
npm install sqlite3 --save
progress 60

status "[n8n] installing n8n"
npm install -g n8n --build-from-source
progress 90

echo "[n8n-bootstrap] Installation completed!"
status "[n8n] completed"
progress 100
