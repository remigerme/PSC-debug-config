@echo off

set "ssh_dir=%USERPROFILE%\.ssh"
if not exist "%ssh_dir%" (
    mkdir "%ssh_dir%"
)
cd /d "%ssh_dir%"

set /p "host=Nom de votre machine de salle info (laisser vide pour 'oncidium') : "
if "%host%"=="" set "host=oncidium"

set /p "key_name=Nom de la cle (laisser vide pour 'key_psc') : "
if "%key_name%"=="" set "key_name=key_psc"

ssh-keygen -t rsa -b 4096 -N "" -f "%key_name%" -q

set /p "username=Nom d'utilisateur (prenom.nom) : "
set "content=Host x
  HostName %host%.polytechnique.fr
  User %username%
  IdentityFile %ssh_dir%\%key_name%
"

echo %content% >> %ssh_dir%\config
echo Fichier config modifie

set /p "password=Mot de passe LDAP X : "
echo.
where plink >nul 2>nul
if %errorlevel% neq 0 (
    echo PuTTY is not installed or not in the system PATH.
) else (
    "%ProgramFiles%\PuTTY\plink" -ssh -l %username% -pw %password% %host%.polytechnique.fr "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys" < %ssh_dir%\%key_name%.pub
    echo Cle ajoutee sur le serveur

    scp setup_remote.sh x:~
    
    echo Essayez maintenant de vous connecter en tapant 'ssh x'
)