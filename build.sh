#!/usr/bin/env bash
set -e

CC="${CC:-cc}"
CFLAGS="${CFLAGS:--O2 -Wall -Wextra -std=c11}"
LDFLAGS="${LDFLAGS:-}"

printf '\033[1;36m=== Cube Build ===\033[0m\n'
$CC $CFLAGS cube.c -lm $LDFLAGS -o cube
printf '\033[1;32mBuild complete: ./cube\033[0m\n'
