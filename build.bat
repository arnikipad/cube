@echo off
setlocal
set CC=gcc
set CFLAGS=-O2 -Wall -Wextra -std=c11

echo === Cube Build ===
where %CC% >nul 2>nul
if errorlevel 1 (
  echo ERROR: gcc was not found in PATH.
  echo Install MinGW-w64 or MSYS2 and add gcc to PATH.
  exit /b 1
)

%CC% %CFLAGS% cube.c -o cube.exe -lm
if errorlevel 1 (
  echo Build failed.
  exit /b 1
)

echo Build complete: cube.exe
endlocal
