#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "[ssh-setup] Resetting Termux mirrors and updating packages..."
echo "updated"

pkg upgrade -y --option Dpkg::Options::="--force-confnew"

echo "[ssh-setup] Reinstalling essential libraries..."
pkg install -y proot tar wget curl apt liblz4 termux-auth

echo "[ssh-setup] Installing OpenSSH, expect, and termux-auth (auto-confirming config changes)..."

pkg install -y --option Dpkg::Options::="--force-confnew" openssh expect

# Generate SSH keys if missing
if [ ! -f ~/.ssh/id_rsa ]; then
    echo "[ssh-setup] Generating new SSH key pair..."
    mkdir -p ~/.ssh
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N "" >/dev/null 2>&1 || true
else
    echo "[ssh-setup] SSH key pair already exists, skipping generation."
fi

echo -e "123changeme\n123changeme" | passwd
# # Set the password using expect
# PASSWORD="123changeme"
# USERNAME="$(whoami)"
# echo "[ssh-setup] Setting password for user '${USERNAME}' using expect..."

# expect <<EOF
# PASSWORD="123changeme"

# expect <<EOF
# spawn passwd
# expect "New password:"
# send "$PASSWORD\r"
# expect "Retype new password:"
# send "$PASSWORD\r"
# expect eof
# EOF

echo "[ssh-setup] Password has been set successfully."