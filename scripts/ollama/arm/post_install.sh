#!/data/data/com.termux/files/usr/bin/bash
# Ollama post-installation setup script
# proot-distro install ubuntu && proot-distro login ubuntu && apt update && apt upgrade -y && sudo curl -fsSL https://ollama.com/install.sh | sh && mkdir -p "$PREFIX/var/lib/ollama"
echo
echo "[ollama-setup] Ollama has been installed successfully!"
echo
echo "[ollama-setup] To verify that Ollama is running, you can check the following endpoint:"
echo "    http://localhost:11434/api/status"
echo
echo "[ollama-setup] To interact with Ollama models via API, use:"
echo "    http://localhost:11434/api/generate"
echo
echo "[ollama-setup] Example curl command to test the endpoint:"
echo "    curl http://localhost:11434/api/status"
echo
echo "[ollama-setup] For more information about Ollama API documentation, visit:"
echo "    https://github.com/ollama/ollama/blob/main/docs/api.md"
echo
echo "[ollama-setup] Common next steps:"
echo "    1. Start the Ollama service (if not already running) "
echo "    2. Pull a model: ollama pull llama2"
echo "    3. Run the model: ollama run llama2"
echo
echo "[ollama-setup] Post-installation setup completed!"
