add_executable(opencv_app main.cpp)

# Force static runtime to match OpenCV
if(MSVC)
    # Set static runtime for MSVC (/MT)
    foreach(flag_var
            CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE
            CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO)
        if(${flag_var} MATCHES "/MD")
            string(REGEX REPLACE "/MD" "/MT" ${flag_var} "${${flag_var}}")
        endif()
    endforeach()
endif()

# Link against OpenCV libraries
target_link_libraries(opencv_app ${OpenCV_LIBS})