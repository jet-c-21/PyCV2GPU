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
mkdir -p build
cd build
print "go to directory: $(pwd)"
print "CONDA_PREFIX = $CONDA_PREFIX"

#export python_exec=$(/usr/bin/python3.7)
#export include_dir=$(/home/phil/anaconda3/include/python3.7m)
#export include_dir2=$(/usr/include/x86_64-linux-gnu/python3.7m)
#export library=$(/home/phil/anaconda3/lib)
#export packages_path=$(/home/phil/anaconda3/lib/python3.7/site-packages)

cmake -D CMAKE_BUILD_TYPE=RELEASE \
  -D CMAKE_INSTALL_PREFIX=/usr/local \
  -D INSTALL_PYTHON_EXAMPLES=ON \
  -D INSTALL_C_EXAMPLES=OFF \
  -D OPENCV_ENABLE_NONFREE=ON \
  -D WITH_CUDA=ON \
  -D WITH_CUDNN=ON \
  -D OPENCV_DNN_CUDA=ON \
  -D ENABLE_FAST_MATH=1 \
  -D CUDA_FAST_MATH=1 \
  -D CUDA_ARCH_BIN=6.1 \
  -D WITH_CUBLAS=1 \
  -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
  -D BUILD_NEW_PYTHON_SUPPORT=ON \
  -D PYTHON3_EXECUTABLE="$CONDA_PREFIX"/bin/python \
  -D PYTHON3_INCLUDE_DIR="$CONDA_PREFIX"/include/python3.6m \
  -D PYTHON3_LIBRARY="$CONDA_PREFIX"/lib \
  -D PYTHON3_PACKAGES_PATH="$CONDA_PREFIX"/lib/python3.6/site-packages/ \
  -D CUDNN_INCLUDE_DIR=/usr/include/ \
  -D CUDNN_LIBRARY=/usr/lib/x86_64-linux-gnu/libcudnn.so.8.4.0 \
  -D CUDNN_VERSION=8.4.0 \
  -D BUILD_EXAMPLES=ON \
  .. && print "cmake ok"


#make -j$(nproc)
#print "Finished \$make"

#echo "$sudo_pwd" | sudo -S make install
