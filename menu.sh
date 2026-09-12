#!/usr/bin/env bash
set -e

while true; do
  clear
  printf '\033[1;36m╔══════════════════════════════════════╗\033[0m\n'
  printf '\033[1;36m║        CUBE BUILD SYSTEM v2.0       ║\033[0m\n'
  printf '\033[1;36m╚══════════════════════════════════════╝\033[0m\n\n'
  echo "1) Build"
  echo "2) Build with debug symbols"
  echo "3) Run animation"
  echo "4) Clean build"
  echo "5) Show compiler"
  echo "6) Exit"
  echo
  read -r -p "Select: " choice

  case "$choice" in
    1) ./build.sh; read -r -p "Press Enter..." ;;
    2) CC="${CC:-cc}" CFLAGS="-O0 -g -Wall -Wextra -std=c11" "$CC" $CFLAGS cube.c -lm -o cube-debug; read -r -p "Press Enter..." ;;
    3) [ -x ./cube ] || ./build.sh; ./cube ;;
    4) rm -f cube cube-debug cube.exe; echo "Clean complete."; read -r -p "Press Enter..." ;;
    5) echo "CC=${CC:-cc}"; ${CC:-cc} --version | head -n 1; read -r -p "Press Enter..." ;;
    6) exit 0 ;;
    *) echo "Invalid option."; sleep 1 ;;
  esac
done
