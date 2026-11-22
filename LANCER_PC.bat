@echo off
chcp 65001 >nul
title LHVC SAVIM Edition - serveur du salon (laisse cette fenetre ouverte)
cd /d "%~dp0server"
where node >nul 2>nul || (echo. & echo Node.js n'est pas installe : telecharge la version LTS sur https://nodejs.org puis relance ce fichier. & echo. & pause & exit /b 1)
node server.js --open
echo.
echo Le serveur s'est arrete.
pause
