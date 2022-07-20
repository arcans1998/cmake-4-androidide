#!/bin/bash

# Script to install NDK into AndroidIDE
install_dir=$HOME
sdk_dir=$install_dir/android-sdk
ndk_dir=$sdk_dir/ndk/24.0.8215888

echo "[NOTICE] This cmake is for aarch64 only !"
echo "[DEBUG] Patching existing cmake config from ${ndk_dir}/build/cmake/android-legacy.toolchain.cmake"
cd $install_dir

# patching cmake config
sed -i 's/if(CMAKE_HOST_SYSTEM_NAME STREQUAL Linux)/if(CMAKE_HOST_SYSTEM_NAME STREQUAL Android)\nset(ANDROID_HOST_TAG linux-aarch64)\nelseif(CMAKE_HOST_SYSTEM_NAME STREQUAL Linux)/g' $ndk_dir/build/cmake/android-legacy.toolchain.cmake
sed -i 's/if(CMAKE_HOST_SYSTEM_NAME STREQUAL Linux)/if(CMAKE_HOST_SYSTEM_NAME STREQUAL Android)\nset(ANDROID_HOST_TAG linux-aarch64)\nelseif(CMAKE_HOST_SYSTEM_NAME STREQUAL Linux)/g' $ndk_dir/build/cmake/android.toolchain.cmake

echo "[DEBUG] Installing cmake version \"3.23.1\" to path ${sdk_dir}/cmake/3.23.1/"
# download cmake
wget https://github.com/MrIkso/AndroidIDE-NDK/raw/main/cmake.zip
# unzip cmake
unzip cmake.zip -d $sdk_dir
rm cmake.zip
# set executable permission for cmake
chmod -R +x $sdk_dir/cmake/3.23.1/bin
# add cmake to path
echo -e "\nPATH=\$PATH:$HOME/android-sdk/cmake/3.23.1/bin" >> $SYSROOT/etc/ide-environment.properties

echo 'Installation Finished. Ndk has been installed successfully!'