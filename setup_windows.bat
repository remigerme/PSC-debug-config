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
echo.>> %ssh_dir%\config
echo Host x>> %ssh_dir%\config
echo   HostName %host%.polytechnique.fr>> %ssh_dir%\config
echo   User %username%>> %ssh_dir%\config
echo   IdentityFile %ssh_dir%\%key_name%>> %ssh_dir%\config
echo Fichier config modifie
endlocal

set "psCommand=powershell -Command "$pword = read-host 'Enter Password' -AsSecureString ; ^
    $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
        [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%p in (`%psCommand%`) do set password=%%p
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