#!/data/data/com.termux/files/usr/bin/bash
# Reset Termux mirrors
pkg update -y
pkg upgrade -y
# Reinstall essential libraries
pkg install -y proot tar wget curl

# Reinstall apt and core libraries
pkg install -y apt
pkg install -y liblz4
echo "[ssh-setup] Starting SSH installation and setup..."

set -e

# Update packages
echo "[ssh-setup] Updating packages..."
pkg update -y && pkg upgrade -y

# Install OpenSSH and expect
echo "[ssh-setup] Installing OpenSSH and expect (auto-confirming config changes)..."
pkg install -y --option Dpkg::Options::="--force-confnew" openssh expect

# Generate SSH keys if missing
if [ ! -f ~/.ssh/id_rsa ]; then
    echo "[ssh-setup] Generating new SSH key pair..."
    mkdir -p ~/.ssh
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N "" >/dev/null 2>&1 || true
else
    echo "[ssh-setup] SSH key pair already exists, skipping generation."
fi

# Set the password using expect
PASSWORD="123changeme"
USERNAME="$(whoami)"

echo "[ssh-setup] Setting password for user '${USERNAME}' using expect..."

expect -c "
spawn passwd $USERNAME
expect \"New password:\"
send \"$PASSWORD\r\"
expect \"Retype new password:\"
send \"$PASSWORD\r\"
expect eof
"

echo "[ssh-setup] Password has been set successfully."


# Display connection info
IP=$(ip addr show wlan0 2>/dev/null | grep 'inet ' | awk '{print $2}' | cut -d/ -f1 | head -n 1)
if [ -z "$IP" ]; then
    IP=$(ip route get 1.1.1.1 2>/dev/null | awk '/src/ {print $7; exit}')
fi
if [ -z "$IP" ]; then
    IP="127.0.0.1"
fi

PORT=8022
echo
echo "[ssh-setup] SSH server is installed. To start the SSH server, tap on the "START" button."
echo "[ssh-setup] Connection info:"
echo "    ssh ${USERNAME}@${IP} -p ${PORT}"
echo
echo "[ssh-setup] Password for the account has been set to: ${PASSWORD}"
echo "SECURITY NOTE: The password '123changeme' is weak. Change it as soon as possible with: passwd"
echo
echo "[ssh-setup] To stop the SSH server, tap on the "STOP" button."

echo "[ssh-setup] SSH installation completed!"
