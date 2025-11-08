#!/data/data/com.termux/files/usr/bin/bash

# Check if n8n is already installed globally
if ! command -v n8n >/dev/null 2>&1; then
    echo "[n8n-bootstrap] n8n not found, starting installation..."

    # Update all packages
    pkg upgrade -y --option Dpkg::Options::="--force-confnew"

    # Install required tools
    pkg install -y python clang make git binutils nodejs-lts

    # Prepare environment
    pip install setuptools
    export CXXFLAGS="--std=c++17"
    export GYP_DEFINES="android_ndk_path=$ANDROID_NDK_HOME"
    export N8N_SECURE_COOKIE=false
    
    # Install n8n from source (specific version)
    npm install sqlite3 --save
    npm install -g n8n@1.116.2 --build-from-source

    echo "[n8n-bootstrap] Installation completed!"
else
    echo "[n8n-bootstrap] n8n is already installed (version: $(n8n --version))"
fi
