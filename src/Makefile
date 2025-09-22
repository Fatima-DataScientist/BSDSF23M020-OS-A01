# Compiler and flags
CC = gcc
CFLAGS = -Wall -I../include -fPIC
OBJDIR = ../obj
BINDIR = ../bin
LIBDIR = ../lib

# Source and object files
SRCS = main.c myfilefunctions.c mystrfunctions.c
OBJS = $(patsubst %.c,$(OBJDIR)/%.o,$(SRCS))

# Targets
all: direct static dynamic

# Direct compilation (Feature 2)
direct: $(OBJS)
	$(CC) -o $(BINDIR)/client $^ 

# Static library build (Feature 3)
static: $(OBJS)
	ar rcs $(LIBDIR)/libmyutils.a $(OBJDIR)/myfilefunctions.o $(OBJDIR)/mystrfunctions.o
	$(CC) -o $(BINDIR)/client_static $(OBJDIR)/main.o -L$(LIBDIR) -lmyutils

# Dynamic library build (Feature 4)
dynamic: $(OBJS)
	$(CC) -shared -o $(LIBDIR)/libmyutils.so $(OBJDIR)/myfilefunctions.o $(OBJDIR)/mystrfunctions.o
	$(CC) -o $(BINDIR)/client_dynamic $(OBJDIR)/main.o -L$(LIBDIR) -lmyutils

# Compile .c to .o
$(OBJDIR)/%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean up
clean:
	@echo "Cleaning up..."
	rm -f $(OBJDIR)/*.o $(BINDIR)/client $(BINDIR)/client_static $(BINDIR)/client_dynamic $(LIBDIR)/libmyutils.a $(LIBDIR)/libmyutils.so
