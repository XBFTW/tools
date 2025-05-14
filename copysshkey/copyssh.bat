@echo off
setlocal

echo =============================
echo SSH Public Key Copier Script
echo =============================
echo.

REM === Prompt for remote username and IP ===
echo This script assumes the public key is saved at %USERPROFILE%\.ssh\xbftwkey-public.pub
set /p REMOTE="Enter remote SSH login (e.g., user@192.168.1.100): "
set /p HOSTNAME_ALIAS="Enter a name to use in your SSH config file (e.g., myserver): "

set PUBKEY=%USERPROFILE%\.ssh\xbftwkey-public.pub
set PRIVKEY=%USERPROFILE%\.ssh\xbftwkey-private
set CONFIG_FILE=%USERPROFILE%\.ssh\config

REM === Check if public key exists ===
if not exist "%PUBKEY%" (
    echo ERROR: Public key not found at %PUBKEY%
    echo Please generate one using: ssh-keygen
    pause
    exit /b 1
)

echo.
echo 🚀 Copying SSH key to %REMOTE%...
type "%PUBKEY%" | ssh %REMOTE% "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys"

if %errorlevel% neq 0 (
    echo ERROR: Failed to copy key. Please check SSH access and credentials.
    pause
    exit /b 1
)

echo DONE: Key copied successfully to %REMOTE%
echo.

REM === Parse user and host ===
for /f "tokens=1,2 delims=@" %%a in ("%REMOTE%") do (
    set SSH_USER=%%a
    set SSH_HOST=%%b
)

REM === Append SSH config entry ===
echo Adding alias '%HOSTNAME_ALIAS%' to SSH config file...

(
    echo.
    echo Host %HOSTNAME_ALIAS%
    echo     HostName %SSH_HOST%
    echo     User %SSH_USER%
    echo     IdentityFile %PRIVKEY%
) >> "%CONFIG_FILE%"

echo DONE: SSH config updated: you can now connect using:
echo     ssh %HOSTNAME_ALIAS%

endlocal
pause
