#!/data/data/com.termux/files/usr/bin/bash
status "[ollama] installing ubuntu and ollama"
proot-distro install ubuntu && proot-distro exec ubuntu -- bash -lc "apt update && apt upgrade -y && curl -fsSL https://ollama.com/install.sh | sh" && mkdir -p "$PREFIX/var/lib/ollama"
progress 80


echo "[ollama-bootstrap] Installation completed!"
status "[ollama] completed"
progress 100
