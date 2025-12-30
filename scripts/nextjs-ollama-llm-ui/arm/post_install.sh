#!/data/data/com.termux/files/usr/bin/bash
# nextjs-ollama-llm-ui post-installation setup script

INSTALL_DIR="$HOME/nextjs-ollama-llm-ui"

echo
echo "[nextjs-ollama-llm-ui-setup] Installation completed successfully!"
echo
echo "[nextjs-ollama-llm-ui-setup] Installation directory:"
echo "    $INSTALL_DIR"
echo
echo "[nextjs-ollama-llm-ui-setup] Configuration:"
echo "    - Environment file: $INSTALL_DIR/.env"
echo "    - Default Ollama URL: http://localhost:11434"
echo
echo "[nextjs-ollama-llm-ui-setup] To modify Ollama URL (if needed):"
echo "    cd $INSTALL_DIR"
echo "    nano .env"
echo "    # Change OLLAMA_URL to your custom URL"
echo
echo "[nextjs-ollama-llm-ui-setup] To start the development server:"
echo "    cd $INSTALL_DIR"
echo "    npm run dev"
echo
echo "[nextjs-ollama-llm-ui-setup] The UI will be available at:"
echo "    http://localhost:3000"
echo
echo "[nextjs-ollama-llm-ui-setup] Important:"
echo "    - Make sure Ollama is running before starting the UI"
echo "    - Use 'ollama serve' to start Ollama if not running"
echo
echo "[nextjs-ollama-llm-ui-setup] For more information:"
echo "    https://github.com/jakobhoeg/nextjs-ollama-llm-ui"
echo
echo "[nextjs-ollama-llm-ui-setup] Post-installation setup completed!"
