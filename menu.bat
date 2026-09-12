@echo off
setlocal
:title
cls
echo ======================================
echo       CUBE BUILD SYSTEM v2.0
echo ======================================
echo.
echo 1. Build
 echo 2. Debug build
 echo 3. Run animation
 echo 4. Clean
 echo 5. Compiler info
 echo 6. Exit
echo.
set /p choice=Select: 
if "%choice%"=="1" goto build
if "%choice%"=="2" goto debug
if "%choice%"=="3" goto run
if "%choice%"=="4" goto clean
if "%choice%"=="5" goto info
if "%choice%"=="6" exit /b 0
echo Invalid option.
pause
goto title

:build
call build.bat
pause
goto title

:debug
where gcc >nul 2>nul
if errorlevel 1 (echo ERROR: gcc not found.&pause&goto title)
gcc -O0 -g -Wall -Wextra -std=c11 cube.c -o cube-debug.exe -lm
if errorlevel 1 (echo Debug build failed.) else echo Debug build complete: cube-debug.exe
pause
goto title

:run
if not exist cube.exe call build.bat
if exist cube.exe cube.exe
pause
goto title

:clean
del /q cube.exe cube-debug.exe 2>nul
echo Clean complete.
pause
goto title

:info
gcc --version
pause
goto title
