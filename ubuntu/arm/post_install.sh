#!/data/data/com.termux/files/usr/bin/bash
# Ubuntu post-installation setup script

echo
echo "[ubuntu-setup] Ubuntu distro has been installed successfully!"
echo
echo "[ubuntu-setup] To start using Ubuntu, run:"
echo "    proot-distro login ubuntu"
echo
echo "[ubuntu-setup] To run a single command in Ubuntu without logging in:"
echo "    proot-distro exec ubuntu apt update"
echo
echo "[ubuntu-setup] To log out from Ubuntu distro, simply type:"
echo "    exit"
echo
echo "[ubuntu-setup] To access Ubuntu files from Termux, they are stored in:"
echo "    $PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu"
echo
echo "[ubuntu-setup] Common next steps:"
echo "    1. Log in to Ubuntu: proot-distro login ubuntu"
echo "    2. Update packages: apt update && apt upgrade"
echo "    3. Install tools: apt install curl git build-essential"
echo
echo "[ubuntu-setup] For more information about proot-distro, visit:"
echo "    https://github.com/termux/proot-distro"
echo
echo "[ubuntu-setup] Post-installation setup completed!"
