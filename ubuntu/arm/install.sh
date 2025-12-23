#!/data/data/com.termux/files/usr/bin/bash
# Created: 2025-12-23T00:00:00Z
set -euo pipefail

# Marker directory for progress/status (override with MARKER_DIR env if needed)
MARKER_DIR="${MARKER_DIR:-$PREFIX/var/lib/ubuntu}"
mkdir -p "$MARKER_DIR"
progress() { echo "$1" > "$MARKER_DIR/progress"; }
status() { echo "$1" > "$MARKER_DIR/status"; }

# Cleanup function on failure
cleanup_on_failure() {
    local exit_code=$?
    status "[ubuntu] installation failed with exit code $exit_code"
    progress 0
    echo "[ubuntu-bootstrap] Installation failed. Cleaning up..."
    
    # Remove incomplete distro installation if it exists
    if proot-distro list | grep -q ubuntu; then
        echo "[ubuntu-bootstrap] Removing incomplete Ubuntu distro installation..."
        proot-distro remove ubuntu --force || true
    fi
    
    exit "$exit_code"
}

trap cleanup_on_failure EXIT

progress 0
status "[ubuntu] starting"

echo "[ubuntu-bootstrap] Starting Ubuntu installation..."

status "[ubuntu] updating packages"
pkg update -y --option Dpkg::Options::="--force-confnew"
progress 20

status "[ubuntu] installing proot-distro"
pkg install proot-distro -y
progress 50

status "[ubuntu] installing ubuntu distro"
echo "[ubuntu-bootstrap] Installing Ubuntu distro (this may take a few minutes)..."

# Retry logic for distro installation
MAX_RETRIES=3
RETRY_COUNT=0
INSTALL_SUCCESS=false

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    RETRY_COUNT=$((RETRY_COUNT + 1))
    
    if [ $RETRY_COUNT -gt 1 ]; then
        echo "[ubuntu-bootstrap] Retry attempt $RETRY_COUNT of $MAX_RETRIES..."
        status "[ubuntu] installing ubuntu distro (retry $RETRY_COUNT/$MAX_RETRIES)"
        
        # Clear cache on retry to avoid corrupted archives
        echo "[ubuntu-bootstrap] Clearing proot-distro cache..."
        rm -rf "$PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu" 2>/dev/null || true
    fi
    
    # Set environment variables to help with proot file descriptor issues
    export PROOT_ALLOW_EXECVE=1
    export PROOT_ALLOW_MMAP=1
    
    if proot-distro install ubuntu 2>&1; then
        INSTALL_SUCCESS=true
        break
    fi
    
    if [ $RETRY_COUNT -lt $MAX_RETRIES ]; then
        echo "[ubuntu-bootstrap] Installation attempt $RETRY_COUNT failed. Waiting before retry..."
        sleep 2
    fi
done

if [ "$INSTALL_SUCCESS" != "true" ]; then
    status "[ubuntu] installation failed after $MAX_RETRIES attempts"
    echo "[ubuntu-bootstrap] Error: Failed to install Ubuntu distro after $MAX_RETRIES attempts"
    exit 1
fi

progress 90

# Check if distro was successfully installed
if ! proot-distro list | grep -q ubuntu; then
    status "[ubuntu] distro verification failed"
    echo "[ubuntu-bootstrap] Error: Ubuntu distro installation verification failed"
    exit 1
fi

status "[ubuntu] running post-install configuration"
echo "[ubuntu-bootstrap] Running post-install configuration..."

# Execute post-install script if it exists
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/post_install.sh" ]; then
    if ! bash "$SCRIPT_DIR/post_install.sh"; then
        status "[ubuntu] post-install failed"
        echo "[ubuntu-bootstrap] Error: Post-install configuration failed"
        exit 1
    fi
fi

trap - EXIT
echo "[ubuntu-bootstrap] Installation completed successfully!"
status "[ubuntu] completed"
progress 100
