#!/data/data/com.termux/files/usr/bin/bash
# Mosquitto MQTT Broker Post-Installation Setup for Termux (ARM)

MOSQUITTO_CONFIG="$PREFIX/etc/mosquitto/mosquitto.conf"
DEFAULT_PORT="1883"
WEBSOCKET_PORT="9001"
USERNAME="$(whoami 2>/dev/null || echo "$(id -un)")"

# Display connection info
IP=$(ip addr show wlan0 2>/dev/null | grep 'inet ' | awk '{print $2}' | cut -d/ -f1 | head -n 1)
if [ -z "$IP" ]; then
    # Try to get default route interface IP
    IP=$(ip route get 1.1.1.1 2>/dev/null | awk '/src/ {print $7; exit}')
fi
if [ -z "$IP" ]; then
    IP="127.0.0.1"
fi

echo
echo "[mosquitto-setup] Mosquitto MQTT Broker is installed successfully!"
echo "[mosquitto-setup] Configuration info:"
echo "    Broker Address: $IP"
echo "    MQTT Port (default): $DEFAULT_PORT"
echo "    WebSocket Port: $WEBSOCKET_PORT"
echo "    Configuration File: $MOSQUITTO_CONFIG"
echo "    Data Directory: $PREFIX/var/lib/mosquitto"
echo "    Log Directory: $PREFIX/var/log/mosquitto"
echo
echo "[mosquitto-setup] To start the Mosquitto broker, use:"
echo "    mosquitto -c $MOSQUITTO_CONFIG"
echo
echo "[mosquitto-setup] To test the broker connection, use:"
echo "    mosquitto_sub -h $IP -t '#' &"
echo "    mosquitto_pub -h $IP -t 'test/topic' -m 'Hello Mosquitto'"
echo
echo "[mosquitto-setup] To stop the Mosquitto broker, use Ctrl+C or:"
echo "    pkill mosquitto"
echo
echo "[mosquitto-setup] Mosquitto installation and setup completed!"
