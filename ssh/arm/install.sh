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
pkg install termux-auth
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
