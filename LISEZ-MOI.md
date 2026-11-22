# 🍷 Lou Honda Vinasse Club · SAVIM Edition — v1.2

L'appli du club pour le **Salon des vignerons (SAVIM)**, Parc Chanot, Marseille, du 20 au 23 novembre 2026.
Chacun note les vins qu'il goûte sur son téléphone, **même sans réseau**. Les notes reviennent chez l'hôte,
qui lance le palmarès en fin de journée. Ni champagne ni gastronomie, et pas de charclage : c'est un projet à part,
indépendant de la soirée classique du club.

| Fichier | À quoi il sert |
|---|---|
| `LANCER_TEST_PC.bat` | **Mode test** sur un PC Windows (+ un téléphone) : voir plus bas |
| `LANCER_PC.bat` | Le vrai salon avec un PC comme serveur (si l'hôte n'utilise pas son téléphone) |
| `INSTALLER_SAVIM_TERMUX.sh` + `LANCER_SAVIM.sh` | Le vrai salon avec le **téléphone Android de l'hôte** comme serveur |
| `LANCER_TESTS.bat` | Vérification automatique : doit afficher `✅ 54/54 tests réussis` |
| `LANCER_TEST.sh` | Le mode test sur Mac ou Linux |
| `docs/Memo_participants.md` | Le mode d'emploi court à envoyer dans le groupe |
| `docs/Publier_sur_GitHub_Pages.md` | Mettre l'appli en ligne pour que les collègues consultent les exposants avant de venir |

**Nouveautés v1.2** : mode **👀 Juste consulter** (sans profil, pour préparer sa visite), guide **GitHub Pages**,
et **🛟 Secours** : un téléphone qui a quitté ton partage avec des notes non reçues propose de te les envoyer par **WhatsApp** (4G), en un geste.

**Nouveautés v1.1** (réponse à l'audit indépendant du 21/11/2026, détail dans `docs/Reponse_audit_v1.1.md`) :
identité de chaque téléphone protégée par une clé secrète, plus de code animateur par défaut, fichier corrompu jamais écrasé
et copies automatiques, règles (notes, 3 cœurs, dates) imposées par le serveur, installateur qui n'active une version que si ses tests passent,
et base enrichie : **465 cuvées sur 77 domaines** (65 cuvées sourcées en plus, voir `docs/verification_base_2026-11-21/`).

Seul **Node.js** est nécessaire (version LTS, sur [nodejs.org](https://nodejs.org)). Rien d'autre à installer.

---

## 🧪 Le mode test (PC + téléphone)

Le mode test range tout **à part** : le serveur écrit dans `server/data-test` et l'appli des téléphones utilise
une mémoire séparée (adresse avec `?test=1`, bandeau jaune « MODE TEST »). Rien ne se mélange avec le vrai salon.

1. Installe Node.js (une fois), dézippe le projet, double-clique **`LANCER_TEST_PC.bat`**.
   Une fenêtre noire s'ouvre (laisse-la ouverte) et la **page de test** s'ouvre dans le navigateur (`http://localhost:3000/test`).
2. La première fois, Windows demande d'autoriser Node.js : coche **Réseaux privés** (et publics si ta box est en « public »),
   sinon le téléphone ne verra pas le PC.
3. Mets le téléphone sur **le même Wi-Fi que le PC** (ta box) et scanne le QR de la carte 📱 avec l'appareil photo.
4. Sur le PC, **💻 Ouvrir l'appli** : le PC devient un 2e dégustateur (une fenêtre de navigation privée = un 3e).
5. Suis **le parcours de test** (14 étapes à cocher, environ 15 min). La page propose aussi :
   - 🤖 **Faux dégustateurs** : des copains virtuels qui ont déjà noté des vins, pour voir des classements bien remplis ;
   - 📡 **Panne simulée** : le serveur refuse les envois pendant 1 ou 3 min. La pastille du téléphone passe au 🟡,
     puis revient au 🟢 toute seule après la panne ;
   - 📎 **Le retardataire** : un fichier de notes à importer sur la page Résultats, comme s'il arrivait par WhatsApp ;
   - 📊 **En direct** : chaque envoi reçu, avec qui et combien de notes ;
   - 🧹 **Remise à zéro** du test (sans code).
6. Le code animateur est affiché sur la page de test (seulement sur le PC du serveur).

**Tester le vrai montage avant le salon** : sur le téléphone de l'hôte, `savim-test` dans Termux lance le même mode test.
Le partage de connexion remplace alors la box. C'est l'essai le plus proche du jour J.

### Si ça coince
| Problème | Solution |
|---|---|
| Le téléphone n'ouvre pas la page | Même Wi-Fi que le PC ? Pare-feu : Windows → *Pare-feu et protection du réseau* → *Autoriser une application* → coche **Node.js** (privé + public). Essaie les autres adresses affichées sous le QR |
| Ça marche sur la box mais pas sur le Wi-Fi « invité » | Les réseaux invités isolent les appareils : utilise le Wi-Fi principal |
| « Le port 3000 est déjà utilisé » | Le serveur tourne déjà dans une autre fenêtre noire : ferme-la |
| Node.js n'est pas reconnu | Réinstalle Node.js puis redémarre le PC |

---

## 📱 Le jour J (téléphone Android de l'hôte)

**Installation** (une fois, puis à chaque nouvelle version) :
1. Installe **Termux** depuis F-Droid (pas le Play Store, version abandonnée).
2. Mets `Lou_Honda_Vinasse_Club_Savim_Edition_v1.2.zip` et `INSTALLER_SAVIM_TERMUX.sh` dans **Téléchargements**.
3. Dans Termux : `termux-setup-storage` (autorise l'accès), puis `bash ~/storage/downloads/INSTALLER_SAVIM_TERMUX.sh`.
4. Ferme et rouvre Termux. Commandes : `savim` (le salon) · `savim-test` (le mode test).

**Au salon** :
1. Active le **partage de connexion**, puis `savim` dans Termux. L'**écran de l'hôte** s'ouvre (`/hote`).
2. Une seule fois : ⚙️ *Réglages* → nom et mot de passe du partage (le QR Wi-Fi apparaît) et **ton numéro WhatsApp** (pour le secours).
   **Le code animateur** est tiré au hasard au premier lancement (6 chiffres). Il s'affiche dans la fenêtre Termux et sur l'écran
   de l'hôte, **seulement sur ton téléphone** (jamais sur ceux des copains). Tu peux le changer dans ⚙️ *Réglages* :
   les connexions ouvertes avec l'ancien code sont alors fermées.
3. Montre à chacun le QR **Wi-Fi**, puis le QR **Appli**. Ensuite tout le monde peut se disperser.
4. Toi aussi tu notes : 🥂 *Mon appli*.
5. Laisse Termux tourner (le « wake lock » empêche Android de l'endormir). La fenêtre affiche chaque envoi reçu.
6. En fin de salon, tout le monde se reconnecte à ton partage : les notes arrivent toutes seules.
   Puis 🏆 *Résultats* → code → **Lancer la révélation**.

Un PC peut aussi servir de serveur : `LANCER_PC.bat` (avec le point d'accès mobile de Windows ou un routeur de poche).

### 🛟 Secours : un copain a quitté ton Wi-Fi avec des notes non reçues
Tant qu'un téléphone est sur ton partage, chaque note part dans la seconde : au moment où il s'éloigne, tu as déjà tout, sauf les notes prises ensuite.
Une fois parti, il **ne peut plus joindre ton serveur** (ton téléphone n'est pas accessible depuis Internet) : aucune appli ne peut alors t'envoyer quoi que ce soit « toute seule » par ce chemin.
Le secours passe donc par **Internet (4G)** :
1. une minute après la perte de ton Wi-Fi, s'il reste des notes non reçues, son appli affiche **🛟 Secours** (et une alerte) ;
2. il touche **💬 Envoyer par WhatsApp à l'hôte** : WhatsApp s'ouvre sur ta conversation avec un message prêt (toutes ses notes), il n'a plus qu'à appuyer sur Envoyer ;
3. toi : copie le message → 🏆 *Résultats* → **📋 Coller un texte reçu** → *Importer*. Aucun double compte, même s'il revient ensuite sur ton Wi-Fi.
Le navigateur exige un geste de sa part (un appui) : un envoi 100 % automatique est impossible depuis une page web. Sans numéro réglé, WhatsApp demande à qui envoyer.
**Et GitHub ?** GitHub Pages ne fait qu'afficher des pages, il ne peut pas recevoir de notes. Le seul moyen serait de mettre une clé d'écriture GitHub *dans la page* : publique, n'importe qui pourrait alors modifier ou effacer le dépôt. Je ne l'ai donc pas fait.

### 🛟 Sauvegardes et incidents
| Situation | Ce qui se passe |
|---|---|
| Chaque note reçue | Écriture sûre (fichier temporaire puis remplacement) ; l'état précédent est gardé en `salon.json.bak` |
| Toutes les 10 min | Copie horodatée dans `server/data/sauvegardes/` (les 40 dernières) |
| Fichier `salon.json` illisible au démarrage | **Jamais écrasé** : mis de côté (`salon.json.corrompu-<date>`), la copie `.bak` est reprise, et une alerte s'affiche sur l'écran de l'hôte et la page Résultats. Les téléphones gardent leurs notes : un renvoi complète sans double compte |
| Besoin d'une copie sur soi | Résultats → 💾 *Sauvegarde complète* (télécharger / restaurer, code animateur demandé) |

---

## 🥂 L'appli (ce que voient les participants)

- **Je goûte** : exposant (recherche par nom, village, appellation, cépage ou numéro) → vin → note → ✓. Trois touches.
- **Note sur 20** au curseur ou en touches rapides, ❤️ coup de cœur (3 pour la journée), 🛒 « j'en ai acheté »,
  degré deviné ou vrai (facultatif), 📝 mémo perso (ne quitte jamais le téléphone).
- **Faire goûter aux copains** : QR ou **code** (`47.3` = 3e vin de l'exposant 47). Le copain ouvre directement le même vin.
- **Bouteille commune** : choisie ensemble, créée par une seule personne, partagée par QR, prix facultatif.
- **Un vin absent de la liste** : ➕, il circule ensuite vers les autres.
- **Exposants** : filtres région, couleur, bio, HVE, « avec cuvées », tris. **Apprendre** : cépages, régions, notions de base.
- **Pastille** en haut : 🟢 l'hôte a tout reçu · 🟡 des notes attendent · ⚪ jamais envoyé.
- **Envoi** : automatique sur le Wi-Fi de l'hôte, sinon 📎 fichier par message (importé sur la page Résultats).
  On peut renvoyer autant de fois qu'on veut : **rien n'est compté deux fois**.
- Les notes des autres restent **secrètes** jusqu'à la révélation : le serveur ne les renvoie jamais aux téléphones.
- **Personne ne peut noter à ta place** : à l'inscription, le téléphone tire une clé secrète qu'il ne montre jamais ;
  ton identifiant en est l'empreinte. Le serveur refuse toute note dont la clé ne correspond pas. Conséquence : le **fichier**
  de notes (📎) contient ta clé : ne l'envoie qu'à l'hôte. Un téléphone inscrit avec la v1.0 reçoit sa clé tout seul à l'ouverture.
- Le serveur impose aussi les règles : notes de 0 à 20 (une note vide n'est jamais un 0), **3 coups de cœur** au plus
  (les plus anciens comptent), dates dans le futur ramenées à l'heure de réception.

### Version en ligne (facultatif)
Le dossier `public/salon` est une appli autonome. Publiée en **https** (Netlify, GitHub Pages…), elle s'ouvre même sans réseau
et la caméra de 📷 *Scanner* marche partout. Envoi des notes : 📤 → *Par le Wi-Fi de l'hôte* (après avoir scanné le QR « Adresse »
de l'écran de l'hôte), ou par fichier. Sa page `resultats.html` marche aussi sans serveur, en important les fichiers.

---

## 🏆 Les classements

Aucun bonus ni malus (prix, caviste, distance, préférence). Deux pistes séparées : **🥂 stands** et **🍾 bouteilles communes**.
Les exposants et les vins sans note n'apparaissent nulle part.

| Vins | Comment |
|---|---|
| 🏆 Général | Moyenne lissée (un vin peu noté est tiré vers la moyenne du jour), 2 notes min. Si le groupe était trop dispersé, les vins à 1 note sont acceptés et c'est signalé |
| ⚖️ Normalisé · 🥉 Olympique | Chacun ramené à son barème · sans la meilleure ni la pire note (3 min.) |
| ⚡ Clivant · 🤝 Corda | Plus grand / plus petit écart entre les notes (3 min.) |
| 🔴⚪🌸🟠🍯🫧 | Meilleurs rouges, blancs, rosés, orange, moelleux et doux, bulles |
| ❤️ Coups de cœur · 🛒 Portefeuille · 💎 Pépite | Le plus de cœurs · le plus acheté · meilleure note pour le prix (communes) |
| 🍇 Cépage roi · 🗺️ Tour de France · 🏰 Domaine du jour · 🌱 Bio / HVE / sans label | Moyennes par cépage, région, exposant, label |

| Personnes | Comment |
|---|---|
| 😇 Brave · 😈 Enculé | Note plus haut / plus bas que les autres sur les mêmes vins |
| 🐑 Mouton · 🤘 Rebelle | Toujours / jamais d'accord avec le groupe |
| 🧭 Explorateur · 🐺 Loup solitaire | Le plus de régions et cépages · le plus de vins goûtés seul |
| 📣 Influenceur · 🔎 Dénicheur | QR les plus scannés · ses trouvailles plaisent aux autres |
| 🔄 Ouvert d'esprit · 🎯 Empégué | Note mieux la couleur qu'il ne préfère pas · degré deviné à 0,5° près |
| 👯 Jumeaux · 🐶🐱 Chien et chat · 🫂 Inséparables | Paires de palais les plus proches, les plus opposées, avec le plus de vins en commun |
| 🪪 La carte de chacun | Nombre de vins, moyenne, meilleur vin, région, cépage, couleur, coups de cœur |

---

## 📚 La base des vins

- **173 exposants** de la liste du site du salon (relevée le 21/11/2026, dite « non exhaustive »). Le numéro affiché est celui de la liste,
  **pas un numéro de stand** (le site n'en donne pas).
- **465 cuvées sur 77 domaines** : 400 relevées sur les sites des domaines le 21/11, plus 65 cuvées sourcées sur les catalogues
  de 4 producteurs (Citadelle, Roustan, Finon, Victor Hertz) lors d'une vérification indépendante. Rien n'est inventé : un champ vide = introuvable.
  Une cuvée tirée d'un catalogue ne garantit pas sa présence au stand (l'appli le signale). Détails : `docs/verification_base_2026-11-21/`.
- **Fiches** : 57 cépages, 14 régions, une soixantaine d'appellations, 12 notions de base.
- Mise à jour (reproductible : même empreinte SHA-256 à chaque reconstruction) : `tools/donnees/` puis
  `python3 tools/build_db.py tools/donnees/exposants_base.py tools/donnees/raw.txt public/salon/data/exposants.js public/salon/data/fiches.js`.

---

## 🗂️ Organisation

```
public/salon/        l'appli (autonome : marche aussi publiée en https)
   app.js              écrans, mémoire du téléphone, QR, envoi
   rankings.js         tous les classements
   resultats.html      page de l'hôte : notes reçues, import, révélation
   recu.html           réception des notes venant de la version en ligne
   data/               exposants.js (base), fiches.js (cépages, régions…)
   vendor/             qrcode.js (MIT), jsQR.js (Apache 2.0)
public/hote.html     écran de l'hôte (QR Wi-Fi / appli / adresse, réglages)
public/test.html     page du mode test
server/app.js        serveur (routes, code animateur, mode test) — aucune dépendance
server/lib/          salon.js (fusion des notes), testmode.js, network.js, file-storage.js
public/salon/vendor/sha256.js   empreinte des clés (JS pur : marche en http)
server/tests/        54 tests (node run-tests.js), dont audit.test.js : chaque constat de l'audit rejoué
server/data/         notes du vrai salon, réglages (code animateur) ; créé au 1er lancement
server/data/sauvegardes/   copies horodatées automatiques (toutes les 10 min, avant remise à zéro ou restauration)
server/data-test/    notes du mode test
```
