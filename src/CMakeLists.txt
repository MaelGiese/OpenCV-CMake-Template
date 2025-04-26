add_executable(opencv_app main.cpp)

# Link against OpenCV libraries
target_link_libraries(opencv_app ${OpenCV_LIBS})

# Print OpenCV information
message(STATUS "OpenCV libraries: ${OpenCV_LIBS}")
message(STATUS "OpenCV include dirs: ${OpenCV_INCLUDE_DIRS}")