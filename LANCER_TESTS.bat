@echo off
chcp 65001 >nul
title LHVC SAVIM Edition - verification
cd /d "%~dp0server"
where node >nul 2>nul || (echo Node.js n'est pas installe : https://nodejs.org & pause & exit /b 1)
node run-tests.js
pause
