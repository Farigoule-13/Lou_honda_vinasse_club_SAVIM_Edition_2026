@echo off
chcp 65001 >nul
title LHVC SAVIM Edition - MODE TEST (laisse cette fenetre ouverte)
cd /d "%~dp0server"
where node >nul 2>nul || (echo. & echo Node.js n'est pas installe : telecharge la version LTS sur https://nodejs.org puis relance ce fichier. & echo. & pause & exit /b 1)
echo Lancement du MODE TEST : la page de test va s'ouvrir dans le navigateur...
node server.js --test --open
echo.
echo Le serveur s'est arrete.
pause
