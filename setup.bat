@echo off
setlocal EnableExtensions
cd /d "%~dp0"

title Cube v2.0 Setup
cls
echo ======================================
echo          CUBE v2.0 SETUP
 echo ======================================
echo.
echo This installer builds the Cube animation
 echo locally and creates a launcher.
echo.

where gcc >nul 2>nul
if errorlevel 1 (
  echo ERROR: GCC was not found in PATH.
  echo Install MinGW-w64 or MSYS2, then reopen this terminal.
  pause
  exit /b 1
)

echo [1/3] Building Cube...
gcc -O2 -Wall -Wextra -std=c11 cube.c -o cube.exe -lm
if errorlevel 1 (
  echo.
  echo Build failed.
  pause
  exit /b 1
)

echo [2/3] Creating local installation directory...
if not exist "bin" mkdir "bin"
copy /Y "cube.exe" "bin\cube.exe" >nul

if exist "run-cube.bat" del /q "run-cube.bat"
(
  echo @echo off
  echo cd /d "%%~dp0"
  echo start "Cube" "bin\cube.exe"
) > "run-cube.bat"

echo [3/3] Setup complete.
echo.
echo Installed: %CD%\bin\cube.exe
echo Launcher:  %CD%\run-cube.bat
echo.
echo Run the animation with run-cube.bat
pause
endlocal
