# Root Makefile to manage recursive builds

CC = gcc
CFLAGS = -Wall -Iinclude
OBJDIR = obj
BINDIR = bin
LIBDIR = lib

.PHONY: all direct static dynamic clean install uninstall

# Default target
all: direct static dynamic

# Direct build (Feature 2)
direct:
	@echo "==> Building direct (recursive: src)"
	$(MAKE) -C src CC="$(CC)" CFLAGS="$(CFLAGS)" OBJDIR="../$(OBJDIR)" BINDIR="../$(BINDIR)" LIBDIR="../$(LIBDIR)" direct

# Static build (Feature 3)
static:
	@echo "==> Building static (recursive: src)"
	$(MAKE) -C src CC="$(CC)" CFLAGS="$(CFLAGS)" OBJDIR="../$(OBJDIR)" BINDIR="../$(BINDIR)" LIBDIR="../$(LIBDIR)" static

# Dynamic build (Feature 4)
dynamic:
	@echo "==> Building dynamic (recursive: src)"
	$(MAKE) -C src CC="$(CC)" CFLAGS="$(CFLAGS)" OBJDIR="../$(OBJDIR)" BINDIR="../$(BINDIR)" LIBDIR="../$(LIBDIR)" dynamic

# Install / Uninstall (Feature 5)
PREFIX ?= /usr/local
BINDIR_INSTALL = $(PREFIX)/bin
LIBDIR_INSTALL = $(PREFIX)/lib
MANDIR_INSTALL = $(PREFIX)/share/man/man1

install: dynamic
	@echo "Installing program, library, and man pages into $(PREFIX)..."
	mkdir -p $(BINDIR_INSTALL)
	mkdir -p $(LIBDIR_INSTALL)
	mkdir -p $(MANDIR_INSTALL)
	cp bin/client_dynamic $(BINDIR_INSTALL)/client
	cp lib/libmyutils.so $(LIBDIR_INSTALL)/
	cp man/man1/* $(MANDIR_INSTALL)/
	cp man/man1/* $(MANDIR_INSTALL)/
	echo "Installation complete."

uninstall:
	@echo "Removing installed files from $(PREFIX)..."
	rm -f $(BINDIR_INSTALL)/client
	rm -f $(LIBDIR_INSTALL)/libmyutils.so
	rm -f $(MANDIR_INSTALL)/mycat.1
	rm -f $(MANDIR_INSTALL)/mygrep.1
	rm -f $(MANDIR_INSTALL)/wordCount.1
	rm -f $(MANDIR_INSTALL)/mystrlen.1
	rm -f $(MANDIR_INSTALL)/mystrcopy.1
	rm -f $(MANDIR_INSTALL)/myfileopen.1
	rm -f $(MANDIR_INSTALL)/myfileclose.1
	rm -f $(MANDIR_INSTALL)/myfilewrite.1
	rm -f $(MANDIR_INSTALL)/myfileread.1

# Clean everything
clean:
	@echo "==> Cleaning all (recursive: src)"
	$(MAKE) -C src clean
