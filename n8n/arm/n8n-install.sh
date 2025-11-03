#!/data/data/com.termux/files/usr/bin/bash

# Controlla se n8n è già installato globalmente
if ! command -v n8n >/dev/null 2>&1; then
    echo "[n8n-bootstrap] n8n non trovato, avvio installazione..."

    # Aggiorna pacchetti
    pkg upgrade -y --option Dpkg::Options::="--force-confnew"

    # Installa tool necessari
    pkg install -y python clang make git binutils nodejs-lts

    # Prepara ambiente
    pip install setuptools
    export CXXFLAGS="--std=c++17"
    export GYP_DEFINES="android_ndk_path=$ANDROID_NDK_HOME"
    export N8N_SECURE_COOKIE=false

    # Installa n8n da sorgente (versione specifica)
    npm install -g n8n@1.116.2 --build-from-source

    echo "[n8n-bootstrap] Installazione completata!"
else
    echo "[n8n-bootstrap] n8n già installato (versione: $(n8n --version))"
fi
