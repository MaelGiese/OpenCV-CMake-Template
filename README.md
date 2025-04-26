# Minimal OpenCV Template

A minimal C++ project template that builds OpenCV from source and links it with your application.

## Directory Structure

```
opencv_template/
├── .gitmodules                 # Git submodule configuration
├── CMakeLists.txt              # Main CMake configuration
├── build.bat                   # Build script for Windows
├── external/                   # External dependencies
│   └── opencv/                 # OpenCV submodule
└── src/                        # Source code
    ├── CMakeLists.txt          # CMake configuration for src
    └── main.cpp                # Sample application
```

## Setup

1. Clone the repository:
   ```
   git clone <your-repo>
   cd opencv_template
   ```

2. Initialize and update the OpenCV submodule:
   ```
   git submodule init
   git submodule update
   ```

## Build

Run the build script:

```
build.bat
```

This will:
1. Create necessary build directories
2. Build minimal OpenCV modules from source
3. Build your sample application

## Run

After building, run the application:

```
.\build\src\Release\opencv_app.exe
```