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
echo "SSH server is running (if sshd started successfully)."
echo "Connection info:"
echo "    ssh ${USERNAME}@${IP} -p ${PORT}"
echo
echo "Password for the account has been set to: ${PASSWORD}"
echo
echo "SECURITY NOTE: The password '123changeme' is weak. Tap on Terminal to change it as soon as possible with: passwd"
echo
echo "If automatic password set failed, run 'passwd' and enter a new password interactively."
echo "To stop the SSH server, run: pkill sshd or tap the Stop button."

echo "SSH installation completed!"