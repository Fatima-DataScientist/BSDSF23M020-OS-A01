
# REPORT.md - Task 5 Draft Answers

## 1. Explain the linking rule in the Makefile
The linking rule:
```
$(TARGET): $(OBJECTS)
    $(CC) $(CFLAGS) -o $(TARGET) $(OBJECTS)
```
**Explanation:**
- This rule tells `make` how to **link all object files (`.o`)** together to produce the final executable (`bin/client`).
- `$(OBJECTS)` represents compiled `.o` files, such as `main.o`, `mystrfunctions.o`, and `myfilefunctions.o`.
- The compiler (`gcc`) combines these into a single runnable program.

**Difference from linking against a library:**
- In this rule, we directly link all `.o` files into the executable.
- When linking against a **library**, you don’t pass individual `.o` files — you pass a library file, such as:
  ```
  gcc -o client main.o -Llib -lmyutils
  ```
  where:
  - `-L` specifies the library folder,
  - `-l` links the pre-built library (e.g., `libmyutils.a` or `libmyutils.so`).
- This makes the build process modular and efficient.

---

## 2. What is a git tag and why is it useful?
A **git tag** is a pointer to a specific commit, used to **mark important points** in a project’s history, like stable versions or milestones.

**Types of tags:**
- **Lightweight Tag:**  
  Just a simple pointer with no extra metadata. Example:  
  ```
  git tag v1.0
  ```
- **Annotated Tag (recommended):**  
  Stores additional information like message, author, and date.  
  Example:  
  ```
  git tag -a v1.0 -m "Stable release version 1.0"
  ```

**Why useful:**
- Provides a clear record of stable releases (e.g., `v0.1.1-multifile`).
- Helps others know which version to use.
- Essential for **GitHub Releases** and automated deployment pipelines.

---

## 3. Purpose of creating a GitHub Release and attaching binaries
- A **GitHub Release** represents an officially packaged version of your project.
- It combines:
  - A tagged commit,
  - A release title and description,
  - Optionally, pre-compiled **binaries** for users to download.

**Why attach binaries like `bin/client`:**
- Saves users from compiling source code themselves.
- Allows non-technical users to directly run the program.
- Good practice for distributing software.

**Example:**
- In this project, attaching `bin/client` means anyone can simply download and run the executable to test the string and file functions.
