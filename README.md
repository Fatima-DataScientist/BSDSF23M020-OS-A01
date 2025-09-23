Operating Systems Assignment – 01
=================================

This project is part of my Operating Systems course. The main goal is to learn how real-world C projects are built, how to use Makefiles, and how to create and use both static and dynamic libraries.

---------------------------------
Learning Objectives
---------------------------------
- Writing modular C code (separating header files and source files).
- Creating static (.a) and dynamic (.so) libraries.
- Understanding the linking process (-I, -L, -l flags).
- Automating builds with Makefile.
- Using git workflow: branching, merging, tagging, and releasing.
- Writing man pages for documentation.

---------------------------------
Project Structure
---------------------------------
BSDSF23M020-OS-A01/
├── src/        # Source code (.c files)
├── include/    # Header files (.h files)
├── lib/        # Static (.a) and Dynamic (.so) libraries
├── bin/        # Final executables
├── obj/        # Object files
├── man/        # Man pages
└── REPORT.md   # Report with answers to given questions

---------------------------------
Features Implemented
---------------------------------
Feature 1: Project Setup
- Created GitHub repo and professional folder structure.
- Pushed initial commit with README and folders.

Feature 2: Multi-file Compilation
- Wrote string functions (mystrlen, mystrcpy, etc.) and file functions (wordCount, mygrep).
- Created a driver program (main.c) to test all functions.
- Wrote a simple Makefile to compile everything directly.
- Tagged release v0.1.1-multifile.

Feature 3: Static Library
- Collected all functions into a static library: libmyutils.a.
- Linked main.c against this static library.
- Analyzed symbols with ar, nm, and readelf.
- Tagged release v0.2.1-static.

Feature 4: Dynamic Library
- Built a shared object library: libmyutils.so.
- Used -fPIC and -shared flags for compilation.
- Compared file sizes of static vs dynamic executables.
- Used LD_LIBRARY_PATH to run the program.
- Tagged release v0.3.1-dynamic.

Feature 5: Documentation (Man Pages)
- Created man pages for functions and the client program.
- Added an install target in the Makefile to copy executable and man pages.
- Verified 'man mycat' and 'client' command work after install.
- Tagged release v0.4.1-final.

---------------------------------
How to Build and Run
---------------------------------
1. Clone the repo:
   git clone https://github.com/Fatima-DataScientist/BSDSF23M020-OS-A01.git
   cd BSDSF23M020-OS-A01

2. Build the project:
   make          # Builds default (dynamic executable)
   make clean    # Cleans all binaries

3. Run executables:
   ./bin/client
   ./bin/client_static      # Run static version
   ./bin/client_dynamic     # Run dynamic version

   For dynamic version, set library path:
   export LD_LIBRARY_PATH=$PWD/lib:$LD_LIBRARY_PATH
   ./bin/client_dynamic

---------------------------------
Example Output
---------------------------------
--- Testing String Functions ---
Length of 'Hello' = 5
Copied string: Hello
Concatenated string: Hello World

--- Testing File Functions ---
Lines: 3, Words: 12, Characters: 60

---------------------------------
Releases
---------------------------------
- v0.1.1-multifile → Multi-file compilation
- v0.2.1-static    → Static library build
- v0.3.1-dynamic   → Dynamic library build
- v0.4.1-final     → Final version with man pages + install

---------------------------------
Author
---------------------------------
- Name: Fatima Tu Zahra
- Roll No: BSDSF23M020
- Instructor: Dr. Muhammad Arif Butt
# BSDSF23M020-OS-A01
