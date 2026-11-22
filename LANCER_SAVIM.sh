#!/usr/bin/env bash
# =========================================================
# Lance le serveur du salon sur le téléphone Android de l'hôte (Termux).
#   savim          → le vrai salon
#   savim-test     → le mode test (notes d'essai rangées à part)
# Active d'abord ton partage de connexion.
# =========================================================
cd "$(dirname "$(readlink -f "$0")")/server" || exit 1
command -v node >/dev/null || { echo "Node.js manque : relance INSTALLER_SAVIM_TERMUX.sh"; exit 1; }
command -v termux-wake-lock >/dev/null && termux-wake-lock      # empêche Android d'endormir le serveur
node server.js --open "$@"
