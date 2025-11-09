PASSWORD="123changeme"
USERNAME="$(whoami 2>/dev/null || echo \"$(id -un)\")"

# Display connection info
IP=$(ip addr show wlan0 2>/dev/null | grep 'inet ' | awk '{print $2}' | cut -d/ -f1 | head -n 1)
if [ -z "$IP" ]; then
    # try get default route interface IP
    IP=$(ip route get 1.1.1.1 2>/dev/null | awk '/src/ {print $7; exit}')
fi
if [ -z "$IP" ]; then
    IP="127.0.0.1"
fi

PORT=8022
echo
echo "[ssh-setup] SSH server is running (if sshd started successfully)."
echo "[ssh-setup] Connection info:"
echo "    ssh ${USERNAME}@${IP} -p ${PORT}"
echo
echo "[ssh-setup] Password for the account has been set to: ${PASSWORD}"
echo
echo "SECURITY NOTE: The password '123changeme' is weak. Change it as soon as possible with: passwd"
echo
echo "[ssh-setup] If automatic password set failed, run 'passwd' and enter a new password interactively."
echo "[ssh-setup] To stop the SSH server, run: pkill sshd"

echo "[ssh-setup] SSH installation completed!"