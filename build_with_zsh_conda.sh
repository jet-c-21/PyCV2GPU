#!/bin/bash

# Ask user to type sudo password
echo "Please enter your sudo password:"
#read -s sudo_pwd

clear
sudo_pwd=1130

# Update packages with sudo
#echo "$sudo_pwd" | sudo -S apt-get update

source ./color_print.sh

eval "$(conda shell.bash hook)"
conda activate cv2gpu
#print "Current Conda ENV: $CONDA_DEFAULT_ENV"
#conda install -y numpy cmake gcc gxx kernel-headers_linux-64 make pkg-config
#print "Finish install dependencies with conda"

#git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib
git checkout 4.1.1
print "checkout to opencv_contrib 4.1.1"
cd ..
print "go back to initial directory: $(pwd)"

#git clone https://github.com/opencv/opencv.git
cd opencv
git checkout 4.1.1
print "checkout to opencv 4.1.1"
mkdir build
cd build
print "go to directory: $(pwd)"

cmake -D CMAKE_BUILD_TYPE=RELEASE \
  -D CMAKE_INSTALL_PREFIX=/usr/local \
  -D WITH_CUDA=ON \
  -D CUDA_ARCH_BIN=6.1 \
  -D CUDA_ARCH_PTX=6.1 \
  -D ENABLE_FAST_MATH=1 \
  -D CUDA_FAST_MATH=1 \
  -D WITH_CUBLAS=1 \
  -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
  -D BUILD_EXAMPLES=ON \
  -D PYTHON_EXECUTABLE=$CONDA_PREFIX/bin/python \
  -D BUILD_opencv_python3=ON \
  -D BUILD_opencv_python2=OFF \
  -D PYTHON3_INCLUDE_DIR=$CONDA_PREFIX/include/python3.6m \
  -D PYTHON3_LIBRARY=$CONDA_PREFIX/lib/libpython3.6m.so \
  .. && print "Finished \$cmake"

#make -j$(nproc)
#print "Finished \$make"

#echo "$sudo_pwd" | sudo -S make install
