# src/Makefile (invoked by top-level Makefile)

# Variables passed from the top-level Makefile, with safe defaults
CC      ?= gcc
CFLAGS  ?= -Wall -I../include
LDFLAGS ?=
OBJDIR  ?= ../obj
BINDIR  ?= ../bin
TARGET  ?= client

# Collect all C source files in this directory
SRCS := $(wildcard *.c)
# Map each .c file to an object file in ../obj
OBJS := $(patsubst %.c,$(OBJDIR)/%.o,$(SRCS))

.PHONY: all clean

# Default target: build the binary in ../bin
all: $(BINDIR)/$(TARGET)

# Linking rule: link all object files into the binary
$(BINDIR)/$(TARGET): $(OBJS)
	@mkdir -p $(BINDIR)
	@echo "Linking -> $@"
	$(CC) $(CFLAGS) -o $(BINDIR)/$(TARGET) $(OBJS) $(LDFLAGS)

# Compilation rule: compile .c -> ../obj/.o
$(OBJDIR)/%.o: %.c
	@mkdir -p $(OBJDIR)
	@echo "Compiling $< -> $@"
	$(CC) $(CFLAGS) -c $< -o $@

# Clean up object files (not binary, top-level clean removes that too)
clean:
	@echo "Cleaning objects in src/"
	@rm -f $(OBJS)

