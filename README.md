# Multi-Library C++ Project Template

```
project_root/
├── CMakeLists.txt              # Main project CMake file
├── build.bat                   # Main build script
├── cmake/                      # Helper CMake modules
│   ├── BuildExternalLib.cmake  # Module to build external libraries
│   └── ProjectSettings.cmake   # Global project settings
├── external/                   # External dependencies (git submodules)
│   ├── opencv/                 # OpenCV submodule
│   ├── other_lib/              # Other library submodule
│   └── ...                     # More libraries as needed
├── src/                        # Application source code
│   ├── CMakeLists.txt          # Application-specific CMake file
│   └── main.cpp                # Main code
└── .gitmodules                 # Git submodules configuration
```

## How It Works

1. Each external library is a git submodule in `external/`
2. The `BuildExternalLib.cmake` module provides a function to build any CMake-based library
3. The root `CMakeLists.txt` handles building all dependencies and then the application
4. The `build.bat` script coordinates the entire build process
5. `ProjectSettings.cmake` contains shared settings across all components