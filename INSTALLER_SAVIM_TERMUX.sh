#!/usr/bin/env bash
# =========================================================
# Installation sur le téléphone Android de l'hôte (une fois, puis à chaque nouvelle version).
# Dans Termux :  bash ~/storage/downloads/INSTALLER_SAVIM_TERMUX.sh
# (si « storage » n'existe pas : tape d'abord  termux-setup-storage)
#
# Sûreté (audit SV-07) : la nouvelle version est installée À CÔTÉ de l'ancienne,
# vérifiée par ses tests, et ne devient la version active QUE si tous les tests passent.
# Sinon l'ancienne reste en place, intacte, et le script s'arrête en erreur.
# =========================================================
set -euo pipefail
fail() { echo ""; echo "❌ $*"; echo "   L'installation précédente (s'il y en a une) n'a pas été modifiée."; exit 1; }
echo "🍷 Installation de Lou Honda Vinasse Club · SAVIM Edition…"
[ -d ~/storage/downloads ] || { termux-setup-storage || true; sleep 4; }
[ -d ~/storage/downloads ] || fail "Autorise l'accès aux fichiers pour Termux, puis relance ce script."
pkg update -y || fail "pkg update a échoué (réseau ?)."
pkg install -y nodejs unzip || fail "Installation de Node.js impossible."
ZIP=$(ls -t ~/storage/downloads/Lou_Honda_Vinasse_Club_Savim_Edition_v*.zip 2>/dev/null | head -1 || true)
[ -n "$ZIP" ] || fail "Aucun Lou_Honda_Vinasse_Club_Savim_Edition_v….zip dans Téléchargements."
NAME=$(basename "$ZIP" .zip)
STAGE=$(mktemp -d ~/.lhvc-install-XXXXXX)
trap 'rm -rf "$STAGE"' EXIT
unzip -q "$ZIP" -d "$STAGE" || fail "Archive illisible : $ZIP"
SRC="$STAGE/$NAME"
[ -f "$SRC/server/server.js" ] || fail "Contenu inattendu dans l'archive (pas de server/server.js)."
# Les notes et réglages de la version active sont copiés (jamais déplacés : l'original reste intact)
if [ -L ~/lhvc-savim ] || [ -d ~/lhvc-savim ]; then
  for D in data data-test; do
    if [ -d ~/lhvc-savim/server/$D ]; then cp -r ~/lhvc-savim/server/$D "$SRC/server/" && echo "↪ $D de la version active copiées."; fi
  done
fi
echo "🧪 Vérification de la nouvelle version…"
RESULT=$(cd "$SRC/server" && node run-tests.js 2>&1) || { echo "$RESULT" | tail -15; fail "Des tests échouent : la nouvelle version n'est PAS activée."; }
echo "$RESULT" | tail -1
DEST=~/"$NAME"
if [ -e "$DEST" ] && [ "$(readlink -f ~/lhvc-savim 2>/dev/null || true)" = "$(readlink -f "$DEST")" ]; then
  # Réinstallation de la même version : on garde une copie de l'ancienne avant de la remplacer
  mv "$DEST" "$DEST.ancien-$(date +%Y%m%d-%H%M%S)"
elif [ -e "$DEST" ]; then
  mv "$DEST" "$DEST.ancien-$(date +%Y%m%d-%H%M%S)"
fi
mv "$SRC" "$DEST"
ln -sfn "$DEST" ~/lhvc-savim
chmod +x ~/lhvc-savim/*.sh
grep -q "alias savim=" ~/.bashrc 2>/dev/null || echo "alias savim='bash ~/lhvc-savim/LANCER_SAVIM.sh'" >> ~/.bashrc
grep -q "alias savim-test=" ~/.bashrc 2>/dev/null || echo "alias savim-test='bash ~/lhvc-savim/LANCER_SAVIM.sh --test'" >> ~/.bashrc
echo ""
echo "✅ Installé et vérifié dans ~/lhvc-savim ($NAME)."
echo "   Ferme et rouvre Termux, puis tape :  savim   (ou  savim-test  pour essayer)"
