# Top-level Makefile

# --- Macros (configurable)
CC      := gcc
INCDIR  := include
SRCDIR  := src
OBJDIR  := obj
BINDIR  :=../bin
LIBDIR  := lib
TARGET  := client

CFLAGS  := -Wall -I$(INCDIR)
LDFLAGS :=

# --- Phony targets
.PHONY: all debug release pre_dirs clean install help

# Default: build everything (delegates to src/ Makefile)
all: pre_dirs
	@echo "==> Building all (recursive: $(SRCDIR))"
	$(MAKE) -C $(SRCDIR) CC="$(CC)" CFLAGS="$(CFLAGS)" OBJDIR="$(OBJDIR)" BINDIR="$(BINDIR)" TARGET="$(TARGET)" LDFLAGS="$(LDFLAGS)"

# Debug build: add debug flags then build
debug: CFLAGS += -g -DDEBUG
debug: clean all

# Release build: optimization flags then build
release: CFLAGS += -O2 -DNDEBUG
release: clean all

# Ensure necessary directories exist before building
pre_dirs:
	@mkdir -p $(OBJDIR) $(BINDIR) $(LIBDIR)

# Clean (delegates to src/)
clean:
	@echo "==> Cleaning (recursive: $(SRCDIR))"
	$(MAKE) -C $(SRCDIR) clean OBJDIR="$(OBJDIR)" BINDIR="$(BINDIR)"
	@rm -f $(BINDIR)/$(TARGET)

# Install (simple, copies binary to /usr/local/bin)
install: all
	@echo "==> Installing $(TARGET) to /usr/local/bin (may need sudo)"
	install -d /usr/local/bin
	install -m 0755 bin/$(TARGET) /usr/local/bin/$(TARGET)


# Help: list available targets
help:
	@echo "Available targets:"
	@echo "  make           # build default (all)"
	@echo "  make debug     # build with debug flags"
	@echo "  make release   # build optimized release"
	@echo "  make clean     # remove build artifacts"
	@echo "  make install   # install binary to /usr/local/bin"
