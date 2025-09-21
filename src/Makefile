# src/Makefile - builds direct, static, and dynamic versions
#
# Usage:
#   make           # builds all (direct, static, dynamic)
#   make direct    # build bin/client (direct link of objects)
#   make static    # build lib/libmyutils.a + bin/client_static
#   make dynamic   # build lib/libmyutils.so + bin/client_dynamic
#   make clean     # remove objects, libraries, and executables

CC        ?= gcc
CFLAGS    ?= -Wall -I../include
PICFLAGS  ?= -Wall -fPIC -I../include
OBJDIR    ?= ../obj
BINDIR    ?= ../bin
LIBDIR    ?= ../lib

LIBSTATIC  := libmyutils.a
LIBDYNAMIC := libmyutils.so

# -------------------------------
# Source files (we are already in src/)
SRCS    := $(wildcard *.c)
OBJS    := $(patsubst %.c,$(OBJDIR)/%.o,$(SRCS))

# Library sources (only utility functions, not main.c)
LIB_SRCS := mystrfunctions.c myfilefunctions.c
LIB_OBJS := $(patsubst %.c,$(OBJDIR)/%.o,$(LIB_SRCS))

.PHONY: all direct static dynamic clean

# -------------------------------
# Default: build everything
all: direct static dynamic

# -------------------------------
# Direct build (Feature 2)
direct: $(BINDIR)/client

$(BINDIR)/client: $(OBJS)
	@mkdir -p $(BINDIR)
	@echo "Linking direct -> $@"
	$(CC) $(CFLAGS) -o $@ $(OBJS)

# -------------------------------
# Static build (Feature 3)
static: $(LIBDIR)/$(LIBSTATIC) $(BINDIR)/client_static

$(LIBDIR)/$(LIBSTATIC): $(LIB_OBJS)
	@mkdir -p $(LIBDIR)
	@echo "Archiving -> $@"
	ar rcs $@ $^

$(BINDIR)/client_static: $(OBJDIR)/main.o $(LIBDIR)/$(LIBSTATIC)
	@mkdir -p $(BINDIR)
	@echo "Linking static -> $@"
	$(CC) $(CFLAGS) -o $@ $(OBJDIR)/main.o -L$(LIBDIR) -lmyutils

# -------------------------------
# Dynamic build (Feature 4)
dynamic: $(LIBDIR)/$(LIBDYNAMIC) $(BINDIR)/client_dynamic

$(LIBDIR)/$(LIBDYNAMIC): $(LIB_OBJS)
	@mkdir -p $(LIBDIR)
	@echo "Building shared library -> $@"
	$(CC) -shared -o $@ $(LIB_OBJS)

$(BINDIR)/client_dynamic: $(OBJDIR)/main.o $(LIBDIR)/$(LIBDYNAMIC)
	@mkdir -p $(BINDIR)
	@echo "Linking dynamic -> $@"
	$(CC) $(CFLAGS) -o $@ $(OBJDIR)/main.o -L$(LIBDIR) -lmyutils

# -------------------------------
# Compile rule (e.g. myfilefunctions.c → ../obj/myfilefunctions.o)
$(OBJDIR)/%.o: %.c
	@mkdir -p $(OBJDIR)
	@echo "Compiling $< -> $@"
	@if echo "$(LIB_SRCS)" | grep -wq `basename $<`; then \
	  $(CC) $(PICFLAGS) -c $< -o $@; \
	else \
	  $(CC) $(CFLAGS) -c $< -o $@; \
	fi

# -------------------------------
# Clean
clean:
	@echo "Cleaning objects, libraries, and binaries"
	@rm -f $(OBJDIR)/*.o
	@rm -f $(LIBDIR)/$(LIBSTATIC) $(LIBDIR)/$(LIBDYNAMIC)
	@rm -f $(BINDIR)/client $(BINDIR)/client_static $(BINDIR)/client_dynamic
