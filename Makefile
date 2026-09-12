CC ?= cc
CFLAGS ?= -O2 -Wall -Wextra -std=c11
LDFLAGS ?=
TARGET = cube

.PHONY: all build debug run clean info

all: build

build:
	$(CC) $(CFLAGS) cube.c $(LDFLAGS) -lm -o $(TARGET)

# Debug build with symbols.
debug:
	$(CC) -O0 -g -Wall -Wextra -std=c11 cube.c $(LDFLAGS) -lm -o cube-debug

run: build
	./$(TARGET)

clean:
	rm -f $(TARGET) cube-debug cube.exe

info:
	@echo "Compiler: $(CC)"
	@$(CC) --version | head -n 1
