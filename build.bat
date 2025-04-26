@echo off
setlocal enabledelayedexpansion

echo Cleaning build directories...
if exist build\opencv_build rmdir /s /q build\opencv_build
if exist build\opencv_install rmdir /s /q build\opencv_install
if not exist build mkdir build
if not exist build\opencv_build mkdir build\opencv_build
if not exist build\opencv_install mkdir build\opencv_install

echo Building OpenCV...
cd build\opencv_build

cmake ..\..\external\opencv ^
  -DCMAKE_INSTALL_PREFIX=..\opencv_install ^
  -DBUILD_opencv_calib3d=OFF ^
  -DBUILD_opencv_features2d=OFF ^
  -DBUILD_opencv_flann=OFF ^
  -DBUILD_opencv_dnn=OFF ^
  -DBUILD_opencv_ml=OFF ^
  -DBUILD_opencv_photo=OFF ^
  -DBUILD_opencv_python_bindings_generator=OFF ^
  -DBUILD_opencv_python2=OFF ^
  -DBUILD_opencv_python3=OFF ^
  -DBUILD_opencv_gapi=OFF ^
  -DBUILD_opencv_objdetect=OFF ^
  -DBUILD_opencv_stitching=OFF ^
  -DBUILD_opencv_ts=OFF ^
  -DBUILD_opencv_video=OFF ^
  -DBUILD_opencv_videoio=OFF ^
  -DBUILD_opencv_world=OFF ^
  -DBUILD_SHARED_LIBS=OFF ^
  -DBUILD_EXAMPLES=OFF ^
  -DBUILD_TESTS=OFF ^
  -DBUILD_PERF_TESTS=OFF ^
  -DBUILD_PROTOBUF=OFF ^
  -DBUILD_opencv_apps=OFF ^
  -DBUILD_DOCS=OFF ^
  -DWITH_EIGEN=OFF ^
  -DCPU_BASELINE=NONE ^
  -DCPU_DISPATCH=NONE ^
  -DWITH_IPP=OFF ^
  -DWITH_ADE=OFF ^
  -DOPENCV_DISABLE_FILESYSTEM_SUPPORT=ON ^
  -DOPENCV_GENERATE_PKGCONFIG=OFF

if %ERRORLEVEL% neq 0 (
  echo CMake configuration failed.
  goto error
)

cmake --build . --config Release -- /m:%NUMBER_OF_PROCESSORS%
if %ERRORLEVEL% neq 0 (
  echo OpenCV build failed.
  goto error
)

cmake --build . --target install --config Release
if %ERRORLEVEL% neq 0 (
  echo OpenCV installation failed.
  goto error
)

cd ..\..

echo Building the main project...
cd build
cmake ..
if %ERRORLEVEL% neq 0 (
  echo Project configuration failed.
  goto error
)

cmake --build . --config Release -- /m:%NUMBER_OF_PROCESSORS%
if %ERRORLEVEL% neq 0 (
  echo Project build failed.
  goto error
)

cd ..

echo.
echo Build complete. To run the application, execute:
echo   .\build\src\Release\opencv_app.exe
goto end

:error
echo Build failed! Check the errors above.
pause
exit /b 1

:end
pause