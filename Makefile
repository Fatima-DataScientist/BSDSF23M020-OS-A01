# ===========================
# Makefile - Feature 4: Dynamic Library Build
# ===========================

CC      := gcc
CFLAGS  := -Wall -Iinclude
OBJDIR  := obj
BINDIR  := bin
LIBDIR  := lib
SRCDIR  := src

TARGET  := client_dynamic
LIBNAME := libmyutils.so

.PHONY: all clean run

# Default target
all: $(BINDIR)/$(TARGET)

# Compile .c -> .o
$(OBJDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(OBJDIR)
	@echo "Compiling $< -> $@"
	$(CC) $(CFLAGS) -fPIC -c $< -o $@

# Collect sources
UTIL_SRCS := $(filter-out $(SRCDIR)/main.c, $(wildcard $(SRCDIR)/*.c))
UTIL_OBJS := $(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.o, $(UTIL_SRCS))

# Build shared library
$(LIBDIR)/$(LIBNAME): $(UTIL_OBJS)
	@mkdir -p $(LIBDIR)
	@echo "Building shared library -> $@"
	$(CC) -shared -o $@ $^

# Link main with shared lib
$(BINDIR)/$(TARGET): $(LIBDIR)/$(LIBNAME) $(OBJDIR)/main.o
	@mkdir -p $(BINDIR)
	@echo "Linking -> $@"
	$(CC) $(OBJDIR)/main.o -L$(LIBDIR) -lmyutils -o $@

# Run program
run: all
	LD_LIBRARY_PATH=$(LIBDIR):$$LD_LIBRARY_PATH ./$(BINDIR)/$(TARGET)

# Clean
clean:
	@echo "Cleaning..."
	rm -f $(OBJDIR)/*.o $(BINDIR)/$(TARGET) $(LIBDIR)/$(LIBNAME)

