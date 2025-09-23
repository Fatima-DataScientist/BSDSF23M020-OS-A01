# REPORT.md  
**Operating Systems Programming Assignment – 01**  
**Student: Fatima Tu Zahra – Roll No: BSDSF23M020**  

---

## 📌 Feature-2: Multi-file Project using Make Utility  

### Q1. Explain the linking rule in this part's Makefile:  
**Rule:**  
```make
$(TARGET): $(OBJECTS)
    $(CC) $(CFLAGS) -o $(TARGET) $(OBJECTS)
```  

- This tells `make` to create the final executable (`$(TARGET)`) from a list of compiled object files (`$(OBJECTS)`).  
- Each `.c` file is compiled into `.o` (object code). Then, all `.o` files are linked together into one binary.  

**Difference from linking against a library:**  
- Here, the **linker directly uses object files**.  
- With a library (static `.a` or dynamic `.so`), the **object files are bundled separately** into a library first. Then the executable is linked against that library using `-L` (path) and `-l` (library name).  

---

### Q2. What is a git tag and why is it useful in a project? What is the difference between a simple tag and an annotated tag?  

- A **git tag** is a named reference to a specific commit, typically used to mark important points like releases.  
- It is useful because it gives a permanent, easy-to-remember label for stable versions (e.g., `v0.1.1-multifile`).  

**Types:**  
- **Lightweight tag:** just a pointer to a commit (like a branch that doesn’t move).  
- **Annotated tag:** stored as a full Git object; includes metadata such as tagger name, email, date, and a message. These are recommended for official releases.  

---

### Q3. What is the purpose of creating a "Release" on GitHub? What is the significance of attaching binaries (like your client executable) to it?  

- A GitHub **Release** packages a specific tag with release notes and optional compiled files.  
- Purpose: makes it easier for others to download and use a stable version without building from source.  
- Attaching binaries (like `bin/client`) allows non-technical users to run the program immediately, without needing to compile it themselves.  

---

## 📌 Feature-3: Creating and using Static Library  

### Q1. Compare the Makefile from Part 2 and Part 3. What are the key differences?  

- **Part 2 Makefile:** directly compiles `.c` files into `.o` and links them all into one binary.  
- **Part 3 Makefile:**  
  - Compiles utility `.c` files into `.o` and then archives them into a **static library (`libmyutils.a`)** using `ar`.  
  - `main.c` is compiled separately and linked with the library instead of linking all `.o` files directly.  
- Key new variables:  
  - `LIBDIR` → where library is stored  
  - `LIBNAME` → static library file (e.g., `libmyutils.a`)  
- Linking rule changes from:  
  ```make
  $(CC) -o $(TARGET) $(OBJECTS)
  ```  
  to:  
  ```make
  $(CC) -o $(TARGET) main.o -Llib -lmyutils
  ```  

---

### Q2. What is the purpose of the `ar` command? Why is `ranlib` often used immediately after it?  

- **`ar` (archiver):** creates a static library (`.a`) by bundling multiple `.o` files.  
  Example:  
  ```bash
  ar rcs libmyutils.a mystrfunctions.o myfilefunctions.o
  ```  
- **`ranlib`:** generates an index of the symbols in the library, so the linker can quickly find functions.  
- Many systems combine `ar rcs` and `ranlib`, but running `ranlib` explicitly is safe practice.  

---

### Q3. When you run `nm` on your `client_static` executable, are the symbols for functions like `mystrlen` present? What does this tell you about how static linking works?  

- Running `nm bin/client_static` shows that the symbols from `libmyutils.a` **are included in the executable itself**.  
- This means:  
  1. Static linking **copies code** from the library into the binary.  
  2. The executable is **self-contained** (doesn’t need the `.a` file to run).  
  3. File size is larger compared to dynamic linking.  

---

## 📌 Feature-4: Creating and using Dynamic Library  

### Q1. What is Position-Independent Code (`-fPIC`) and why is it a requirement for creating shared libraries?  

- **Position-Independent Code (PIC):** machine code that can run correctly regardless of its memory address.  
- Required for `.so` (shared libraries), because they can be loaded into different places in memory by different processes.  
- `-fPIC` ensures no hardcoded memory addresses are used.  

---

### Q2. Explain the difference in file size between your static and dynamic clients. Why does this difference exist?  

- `bin/client_static` is **larger** than `bin/client_dynamic`.  
- Reason:  
  - **Static linking:** copies all used code from the library into the executable → larger size.  
  - **Dynamic linking:** only stores references to the shared library, which is loaded at runtime → smaller size.  

---

### Q3. What is the `LD_LIBRARY_PATH` environment variable? Why was it necessary to set it?  

- **LD_LIBRARY_PATH:** tells the dynamic loader (`ld.so`) where to look for shared libraries at runtime.  
- By default, the loader only checks system directories (like `/lib` or `/usr/lib`).  
- Since our custom `libmyutils.so` is in `./lib`, we must set:  
  ```bash
  export LD_LIBRARY_PATH=lib:$LD_LIBRARY_PATH
  ```  
- This teaches us: it is the **responsibility of the OS dynamic loader** to locate and load shared libraries before starting the program.  

---
