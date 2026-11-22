#!/usr/bin/env bash
# Mode test sur Mac / Linux (ou Termux) : page de test sur http://localhost:3000/test
cd "$(dirname "$(readlink -f "$0" 2>/dev/null || echo "$0")")/server" || exit 1
command -v node >/dev/null || { echo "Node.js manque : https://nodejs.org"; exit 1; }
node server.js --test --open
