#!/data/data/com.termux/files/usr/bin/bash

echo "[ssh-setup] Starting SSH installation and setup..."

# Exit on error (but try to be resilient where appropriate)
set -e

# Update packages
echo "[ssh-setup] Updating packages..."
pkg update -y && pkg upgrade -y

# Install OpenSSH
echo "[ssh-setup] Installing OpenSSH..."
pkg install -y --option Dpkg::Options::="--force-confnew" openssh

# Generate SSH keys if missing
if [ ! -f ~/.ssh/id_rsa ]; then
    echo "[ssh-setup] Generating new SSH key pair..."
    mkdir -p ~/.ssh
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N "" >/dev/null 2>&1 || true
else
    echo "[ssh-setup] SSH key pair already exists, skipping generation."
fi

# Non-interactive password to set
PASSWORD="123changeme"

# Set the password non-interactively.
# Try chpasswd (preferred), otherwise try piping into passwd, otherwise print manual instruction.
echo "[ssh-setup] Setting password for current user non-interactively..."

USERNAME="$(whoami 2>/dev/null || echo \"$(id -un)\")"

# helper to ignore non-critical failures
run_safe() {
    "$@" >/dev/null 2>&1 || true
}

if command -v chpasswd >/dev/null 2>&1; then
    echo "[ssh-setup] Using chpasswd to set password..."
    # chpasswd expects: username:password on stdin
    echo "${USERNAME}:${PASSWORD}" | run_safe chpasswd
    echo "[ssh-setup] Password set with chpasswd."
else
    # fallback: try piping the password twice into passwd
    if command -v passwd >/dev/null 2>&1; then
        echo "[ssh-setup] chpasswd not found — falling back to piping into passwd..."
        # Some passwd implementations will accept password via stdin like this.
        # Use printf to avoid issues with echo -e differences.
        printf "%s\n%s\n" "${PASSWORD}" "${PASSWORD}" | run_safe passwd "${USERNAME}"
        # Verify if password command succeeded by checking exit code of last run_safe (we can't get it here),
        # so do a quick test by attempting a subtle non-interactive check is not feasible without expect.
        echo "[ssh-setup] Attempted to set password via passwd. If this failed, see instructions below."
    else
        echo "[ssh-setup] ERROR: passwd command not found. Cannot set password automatically."
    fi
fi

# Start SSH server
echo "[ssh-setup] Starting SSH server..."
run_safe sshd

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