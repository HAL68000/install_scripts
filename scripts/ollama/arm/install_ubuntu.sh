#!/data/data/com.termux/files/usr/bin/bash
status "[ollama] installing ubuntu"
sh "proot-distro install ubuntu"
progress 80
status "[ollama] installing ollama"
proot-distro exec ubuntu -- bash -lc "apt update && apt upgrade -y && curl -fsSL https://ollama.com/install.sh | sh" && mkdir -p "$PREFIX/var/lib/ollama
progress 90
echo "[ollama-bootstrap] Installation completed!"
status "[ollama] completed"
progress 100
