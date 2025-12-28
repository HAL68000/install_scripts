#!/data/data/com.termux/files/usr/bin/bash
# Mosquitto MQTT Broker Uninstallation Script for Termux (ARM)
echo "[mosquitto-uninstall] Starting Mosquitto uninstallation..."

run_safe() {
    "$@" >/dev/null 2>&1 || true
}

# Clear potential apt locks first
echo "[mosquitto-uninstall] Checking for apt locks..."
run_safe rm -f /data/data/com.termux/files/usr/var/lib/dpkg/lock
run_safe rm -f /data/data/com.termux/files/usr/var/lib/apt/lists/lock
run_safe rm -f /data/data/com.termux/files/usr/var/cache/apt/archives/lock
run_safe dpkg --configure -a

# Stop Mosquitto broker
echo "[mosquitto-uninstall] Stopping Mosquitto broker..."
run_safe pkill -9 mosquitto
run_safe pkill -9 mosquitto_broker

# Uninstall Mosquitto safely
echo "[mosquitto-uninstall] Uninstalling Mosquitto package..."
run_safe env DEBIAN_FRONTEND=noninteractive apt-get purge -y mosquitto

# Remove configuration, data, and logs
echo "[mosquitto-uninstall] Removing Mosquitto configuration, data, and logs..."
run_safe rm -rf "$PREFIX/etc/mosquitto"
run_safe rm -rf "$PREFIX/var/lib/mosquitto"
run_safe rm -rf "$PREFIX/var/log/mosquitto"
run_safe rm -f "$PREFIX/var/lib/mosquitto/progress"
run_safe rm -f "$PREFIX/var/lib/mosquitto/status"

# Cleanup
echo "[mosquitto-uninstall] Mosquitto has been successfully uninstalled."
