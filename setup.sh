#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

printf '\033[1;36m======================================\033[0m\n'
printf '\033[1;36m         CUBE v2.0 SETUP              \033[0m\n'
printf '\033[1;36m======================================\033[0m\n\n'

if ! command -v cc >/dev/null 2>&1; then
  echo "ERROR: A C compiler (cc) was not found in PATH."
  exit 1
fi

echo "[1/3] Building Cube..."
cc -O2 -Wall -Wextra -std=c11 cube.c -lm -o cube

echo "[2/3] Creating local installation directory..."
mkdir -p bin
cp cube bin/cube
chmod +x bin/cube
cat > run-cube.sh <<'EOF'
#!/usr/bin/env bash
cd "$(dirname "$0")"
exec ./bin/cube
EOF
chmod +x run-cube.sh

echo "[3/3] Setup complete."
echo "Installed: $(pwd)/bin/cube"
echo "Launcher:  $(pwd)/run-cube.sh"
echo
echo "Run: ./run-cube.sh"
