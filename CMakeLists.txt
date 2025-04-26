cmake_minimum_required(VERSION 3.15)
project(opencv_template VERSION 1.0)

# Set C++ standard
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Set static runtime (/MT) for all targets
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

# Set OpenCV build and install directories
set(OPENCV_INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}/opencv_install)

# Set OpenCV_DIR to help find_package locate the built OpenCV
set(OpenCV_DIR ${OPENCV_INSTALL_DIR}/x64/vc17/staticlib CACHE PATH "Path to OpenCVConfig.cmake")

# Find the built OpenCV package
find_package(OpenCV REQUIRED)

# Add the source code directory
add_subdirectory(src)