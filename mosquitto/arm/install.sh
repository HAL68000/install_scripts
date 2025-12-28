#!/data/data/com.termux/files/usr/bin/bash
# Created: 2025-12-28T00:00:00Z
# Mosquitto MQTT Broker Installation Script for Termux (ARM)
set -euo pipefail

# Marker directory for progress/status (override with MARKER_DIR env if needed)
MARKER_DIR="${MARKER_DIR:-$PREFIX/var/lib/mosquitto}"
mkdir -p "$MARKER_DIR"
progress() { echo "$1" > "$MARKER_DIR/progress"; }
status() { echo "$1" > "$MARKER_DIR/status"; }

progress 0
status "[mosquitto] starting"

echo "[mosquitto-setup] Resetting Termux mirrors and updating packages..."

status "[mosquitto] upgrading packages"
pkg upgrade -y --option Dpkg::Options::="--force-confnew"
progress 20

status "[mosquitto] installing mosquitto"
echo "[mosquitto-setup] Installing Mosquitto MQTT Broker..."
pkg install -y mosquitto
progress 60

# Create mosquitto data directory
status "[mosquitto] creating data directory"
mkdir -p "$PREFIX/var/lib/mosquitto"
mkdir -p "$PREFIX/etc/mosquitto"
mkdir -p "$PREFIX/var/log/mosquitto"
progress 80

echo "[mosquitto-setup] Installation completed!"
status "[mosquitto] completed"
progress 100
