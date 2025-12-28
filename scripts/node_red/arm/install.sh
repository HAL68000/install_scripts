#!/data/data/com.termux/files/usr/bin/bash

# Check if n8n is already installed globally
if ! command -v node-red >/dev/null 2>&1; then
    echo "[node-red-bootstrap] n8n not found, starting installation..."

    # Update all packages
    pkg upgrade -y --option Dpkg::Options::="--force-confnew"

    # Install required tools
    pkg install -y nodejs
    npm install -g --unsafe-perm node-red
    echo "[node-red-bootstrap] Installation completed!"
else
    echo "[node-red-bootstrap] node-red is already installed (version: $(node-red --version))"
fi
    