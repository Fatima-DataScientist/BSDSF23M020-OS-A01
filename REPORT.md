Feature 4 – Dynamic Libraries Report

1. What is Position-Independent Code (-fPIC) and why is it a fundamental requirement for creating shared libraries?
- Position-Independent Code (PIC) means the generated machine code does not depend on being loaded at a specific memory address. Instead, it uses relative addressing so that the same code can run correctly regardless of where it is loaded in memory. 
- This is fundamental for shared libraries because the operating system’s dynamic loader can load a shared library at different memory addresses in different programs, without recompiling the library.

2. Explain the difference in file size between your static and dynamic clients. Why does this difference exist?
- The static client (client_static) is larger because all library code is copied directly into the executable at link time. 
- The dynamic client (client_dynamic) is smaller because it only contains references to the shared library; the actual library code remains in the shared object (.so) file and is loaded at runtime. 
- Therefore, the difference exists because static linking duplicates library code in every executable, while dynamic linking shares a single library among programs.

3. What is the LD_LIBRARY_PATH environment variable? Why was it necessary to set it for your program to run, and what does this tell you about the responsibilities of the operating system's dynamic loader?
- LD_LIBRARY_PATH is an environment variable that tells the dynamic loader where to look for shared libraries before searching the default system directories. 
- We had to set it to include ./lib so that the loader could find our custom libmyutils.so when running client_dynamic. 
- This demonstrates that it is the responsibility of the operating system’s dynamic loader to locate, load, and link shared libraries at runtime, using LD_LIBRARY_PATH as a search path.
