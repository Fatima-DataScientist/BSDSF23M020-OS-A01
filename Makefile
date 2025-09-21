# ===========================
# Makefile - Feature 3: Static Library Build
# ===========================

# ---- Macros ----
CC      := gcc
CFLAGS  := -Wall -Iinclude
OBJDIR  := obj
BINDIR  := bin
LIBDIR  := lib
SRCDIR  := src
TARGET  := client_static
LIBNAME := libmyutils.a

# ---- Phony Targets ----
.PHONY: all clean run analyze

# ---- Default Target ----
all: $(BINDIR)/$(TARGET)

# Step 1: Build object files for string and file functions
$(OBJDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(OBJDIR)
	@echo "Compiling $< -> $@"
	$(CC) $(CFLAGS) -c $< -o $@

# Collect all C files except main.c
UTIL_SRCS := $(filter-out $(SRCDIR)/main.c, $(wildcard $(SRCDIR)/*.c))
UTIL_OBJS := $(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.o, $(UTIL_SRCS))

# Step 2: Create the static library from utility object files
$(LIBDIR)/$(LIBNAME): $(UTIL_OBJS)
	@mkdir -p $(LIBDIR)
	@echo "Archiving into static library -> $@"
	ar rcs $@ $(UTIL_OBJS)

# Step 3: Link main.c with the static library to create the final executable
$(BINDIR)/$(TARGET): $(LIBDIR)/$(LIBNAME) $(OBJDIR)/main.o
	@mkdir -p $(BINDIR)
	@echo "Linking main.o with static library -> $@"
	$(CC) $(CFLAGS) $(OBJDIR)/main.o -L$(LIBDIR) -lmyutils -o $@

# ---- Run the program ----
run: all
	./$(BINDIR)/$(TARGET)

# ---- Analyze the static library ----
analyze:
	@echo "--- ar -t ---"
	ar -t $(LIBDIR)/$(LIBNAME)
	@echo "--- nm ---"
	nm $(LIBDIR)/$(LIBNAME)
	@echo "--- readelf -s ---"
	readelf -s $(LIBDIR)/$(LIBNAME)

# ---- Clean up build artifacts ----
clean:
	@echo "Cleaning up..."
	rm -f $(OBJDIR)/*.o $(BINDIR)/$(TARGET) $(LIBDIR)/$(LIBNAME)


