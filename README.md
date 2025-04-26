# Cross-Platform External Libraries CMake Template

This template provides a clean framework for C++ projects that use external libraries as Git submodules. It creates a modular, easy-to-extend system where each external library has its own dedicated configuration file. The template works on both Windows and Linux.

## Project Structure

```
project/
├── cmake/
│   ├── ExternalLibraries.cmake     # Central manager for all external libraries
│   ├── external/
│   │   └── opencv.cmake            # OpenCV-specific configuration
│   └── templates/
│       └── library.cmake.template  # Template for adding new libraries
├── external/
│   └── opencv/                     # OpenCV submodule (original repository)
├── src/
│   ├── CMakeLists.txt              # Source code build configuration
│   └── main.cpp                    # Main application
├── .gitmodules                     # Git submodules definition
├── build.bat                       # Windows build script
├── build.sh                        # Linux build script
└── CMakeLists.txt                  # Main project configuration
```

## How It Works

The system uses a modular approach with these key components:

1. **Central Manager (`ExternalLibraries.cmake`)**: 
   - Provides functions to register and configure external libraries
   - Automatically includes all libraries defined in `cmake/external/`
   - Handles platform-specific settings

2. **Library-Specific Files (`cmake/external/*.cmake`)**: 
   - Each library has its own configuration file
   - Defines build options specific to the library
   - Provides a configuration function for the main build phase

3. **Two-Phase Build Process**:
   - Phase 1 (`BUILD_DEPS`): Builds all external dependencies
   - Phase 2 (`MAIN`): Configures dependencies and builds the main project

## Adding a New External Library

1. **Add the library as a Git submodule**:
   ```bash
   git submodule add https://github.com/example/library.git external/library_name
   ```

2. **Create a configuration file**:
   - Copy `cmake/templates/library.cmake.template` to `cmake/external/library_name.cmake`
   - Edit to set the correct name and build options for your library

   ```cmake
   # Register the library
   register_external_library(NAME library_name)

   # Define build options
   add_external_library_phase(
       NAME library_name
       PHASE build
       CMAKE_ARGS
           -DBUILD_SHARED_LIBS=OFF
           # Add library-specific options here
   )

   # Define the configuration function
   function(configure_library_name)
       # Platform-specific settings
       if(WIN32)
           set(Library_DIR ${library_name_INSTALL_DIR}/lib/cmake/Library CACHE PATH "Path to LibraryConfig.cmake")
       else()
           set(Library_DIR ${library_name_INSTALL_DIR}/lib/cmake/Library CACHE PATH "Path to LibraryConfig.cmake")
       endif()

       find_package(LibraryName REQUIRED)
       update_external_library(
           NAME library_name
           INCLUDES "${LibraryName_INCLUDE_DIRS}"
           LIBRARIES "${LibraryName_LIBRARIES}"
       )
   endfunction()
   ```

3. **Update the main CMakeLists.txt** to call your configuration function:
   ```cmake
   # In the MAIN phase section of CMakeLists.txt
   configure_opencv()
   configure_library_name()  # Add this line
   ```

4. **Link with the library in your code**:
   ```cmake
   # In your target's CMakeLists.txt
   target_link_with_external(your_target library_name)
   ```

## Example: Adding Boost as a Dependency

Here's an example of how to add Boost as a dependency:

```cmake
# In cmake/external/boost.cmake
register_external_library(NAME boost)

add_external_library_phase(
    NAME boost
    PHASE build
    CMAKE_ARGS
        -DBUILD_SHARED_LIBS=OFF
        -DBOOST_BUILD_EXAMPLES=OFF
        -DBOOST_BUILD_TOOLS=OFF
        -DBOOST_INCLUDE_LIBRARIES=filesystem,system
)

function(configure_boost)
    # Platform-specific settings
    if(WIN32)
        set(Boost_ROOT ${boost_INSTALL_DIR})
    else()
        set(Boost_ROOT ${boost_INSTALL_DIR})
    endif()
    
    set(Boost_USE_STATIC_LIBS ON)
    find_package(Boost REQUIRED COMPONENTS filesystem system)
    update_external_library(
        NAME boost
        INCLUDES "${Boost_INCLUDE_DIRS}"
        LIBRARIES "${Boost_LIBRARIES}"
    )
endfunction()
```

## Building the Project

### Windows:
```batch
build.bat
```

### Linux:
```bash
chmod +x build.sh
./build.sh
```

The build script automatically handles both build phases:
1. Builds all external dependencies first
2. Then builds the main project with the dependencies