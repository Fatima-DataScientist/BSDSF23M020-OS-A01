REPORT - Feature 3 (Static Library)

Q1: Compare the Makefile from Part 2 and Part 3. What are the key differences in the variables and rules that enable the creation of a static library?

- Part 2 Makefile (Multi-file build):
  * Compiled each .c file into .o and then directly linked all objects into the final binary (bin/client).
  * Only one linking step.
  * No library was created, objects were always rebuilt together.

- Part 3 Makefile (Static library build):
  * Introduced new variables:
    - LIBDIR → directory for libraries.
    - LIBNAME → name of the static library (libmyutils.a).
  * Added a rule to build the static library using object files:
      $(LIBDIR)/$(LIBNAME): $(OBJDIR)/myfilefunctions.o $(OBJDIR)/mystrfunctions.o
          ar rcs $@ $^
  * Final binary (bin/client) is linked against the static library with -L$(LIBDIR) -lmyutils instead of directly using object files.

Key difference: Part 2 links objects directly, while Part 3 first archives them into a reusable library (.a) and then links against that library.


Q2: What is the purpose of the ar command? Why is ranlib often used immediately after it?

- ar (archiver):
  * Combines multiple .o files into a single archive file (static library .a).
  * Example: ar rcs libmyutils.a myfilefunctions.o mystrfunctions.o

- ranlib:
  * Generates an index (symbol table) for the .a file.
  * Helps the linker (ld) quickly find which object file contains which symbol.
  * On many modern systems, ar rcs already updates the index, so ranlib is sometimes optional — but traditionally it is run immediately after ar.

Summary: ar creates the library, ranlib makes it efficient to use during linking.


Q3: When you run nm on your client_static executable, are the symbols for functions like mystrlen present? What does this tell you about how static linking works?

- If you run: nm bin/client | grep mystrlen
  you will see the symbol for mystrlen inside the executable itself.

- This means:
  * During static linking, the actual machine code of required functions from libmyutils.a is copied into the final executable.
  * The binary is self-contained and does not need the library file at runtime.
  * This is different from dynamic linking, where functions remain in a shared .so file and are resolved at runtime.

Answer: Yes, mystrlen (and other functions) are present in the executable. This proves that static linking copies the library code into the final binary, making it larger but independent of external libraries at runtime.
