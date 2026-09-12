# Cube — Fully Animated C Build System v2.0

An ASCII 3D multi-cube animation written in C.

## Build menu

### Linux / macOS / Unix

```bash
chmod +x build.sh menu.sh
./menu.sh
```

### Windows

Run `menu.bat` from a MinGW-w64/MSYS2 environment with `gcc` available in PATH.

## Menu

1. Build
2. Debug build
3. Run animation
4. Clean build
5. Compiler information
6. Exit

## Direct builds

```bash
make
make debug
make run
make clean
```

Or use `build.sh` / `build.bat`.

## Animation

The renderer uses floating-point 3D rotation, perspective projection, a z-buffer, three independently sized cubes, and continuous frame updates.
