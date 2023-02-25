#!/bin/bash
source ./color_print.sh
print $(which python)
eval "$(conda shell.bash hook)"
conda deactivate
print $(which python3)

mkdir opencvbuild && cd opencvbuild
git clone -b 4.5.2 https://github.com/opencv/opencv.git
git clone -b 4.5.2 https://github.com/opencv/opencv_contrib.git
cd opencv && mkdir build && cd build

print "Finish download opencv and opencv_contrib"

sudo_pwd=1130

echo "$sudo_pwd" | sudo -S apt install -y python3-dev python3-pip gcc-7 g++-7 cmake \
build-essential git pkg-config ccache libxshmfence-dev libasound2-dev \
unzip extra-cmake-modules mesa-utils libgtk-3-dev ffmpeg \
libavcodec-dev libavformat-dev libswscale-dev libtbb-dev libogre-1.9-dev \
libjpeg-dev libpng-dev libtiff5-dev x264 libxvidcore-dev yasm \
libxine2-dev libv4l-dev libfaac-dev libmp3lame-dev libopencore-amrnb-dev \
libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev \
x264 v4l-utils ffmpeg libdc1394-22 libdc1394-22-dev libtiff5-dev \
qt5-default libeigen3-dev libeigen3-doc tesseract-ocr tesseract-ocr-jpn \
vtk7 tcl-vtk7 python3-vtk7 libgflags-dev autoconf automake libtool \
autoconf-archive libleptonica-dev libtesseract-dev gphoto2 liblapacke-dev \
libgstreamer1.0-0 gstreamer1.0-tools gstreamer1.0-plugins-base \
gstreamer1.0-plugins-good gstreamer1.0-plugins-bad \
gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-doc \
gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa \
gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 libhdf5-dev \
libatlas-base-dev gstreamer1.0-opencv libva-dev

pip3 install pip --upgrade
pip3 install onnx onnxruntime

print "Finish download dependencies"

cmake \
-DCMAKE_BUILD_TYPE=RELEASE \
-DCMAKE_INSTALL_PREFIX=/usr/local \
-DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
-DCUDA_ARCH_BIN=6.1 \
-DCUDA_ARCH_PTX="" \
-DOPENCV_GENERATE_PKGCONFIG=ON \
-DBUILD_opencv_apps=ON \
-DBUILD_opencv_calib3d=ON \
-DBUILD_opencv_core=ON \
-DBUILD_opencv_cudaarithm=ON \
-DBUILD_opencv_cudabgsegm=ON \
-DBUILD_opencv_cudacodec=ON \
-DBUILD_opencv_cudafeatures2d=ON \
-DBUILD_opencv_cudafilters=ON \
-DBUILD_opencv_cudaimgproc=ON \
-DBUILD_opencv_cudalegacy=ON \
-DBUILD_opencv_cudaobjdetect=ON \
-DBUILD_opencv_cudaoptflow=ON \
-DBUILD_opencv_cudastereo=ON \
-DBUILD_opencv_cudawarping=ON \
-DBUILD_opencv_cudev=ON \
-DBUILD_opencv_features2d=ON \
-DBUILD_opencv_flann=ON \
-DBUILD_opencv_highgui=ON \
-DBUILD_opencv_imgcodecs=ON \
-DBUILD_opencv_imgproc=ON \
-DBUILD_opencv_ml=ON \
-DBUILD_opencv_objdetect=ON \
-DBUILD_opencv_photo=ON \
-DBUILD_opencv_stitching=ON \
-DBUILD_opencv_superres=ON \
-DBUILD_opencv_ts=ON \
-DBUILD_opencv_video=ON \
-DBUILD_opencv_videoio=ON \
-DBUILD_opencv_videostab=ON \
-DWITH_1394=ON \
-DWITH_CUBLAS=ON \
-DWITH_CUDA=ON \
-DWITH_CUFFT=ON \
-DWITH_EIGEN=ON \
-DWITH_FFMPEG=ON \
-DWITH_GDAL=OFF \
-DWITH_GPHOTO2=ON \
-DWITH_GIGEAPI=ON \
-DWITH_GSTREAMER=ON \
-DWITH_GTK=ON \
-DWITH_INTELPERC=OFF \
-DWITH_IPP=ON \
-DWITH_IPP_A=OFF \
-DWITH_JASPER=ON \
-DWITH_JPEG=ON \
-DWITH_LIBV4L=ON \
-DWITH_ONNX=ON \
-DWITH_OPENCL=ON \
-DWITH_OPENCLAMDBLAS=OFF \
-DWITH_OPENCLAMDFFT=OFF \
-DWITH_OPENCL_SVM=OFF \
-DWITH_OPENEXR=ON \
-DWITH_OPENGL=ON \
-DWITH_OPENMP=OFF \
-DWITH_OPENNI=OFF \
-DWITH_PNG=ON \
-DWITH_PTHREADS_PF=OFF \
-DWITH_PVAPI=ON \
-DWITH_QT=ON \
-DWITH_TBB=ON \
-DWITH_TIFF=ON \
-DWITH_UNICAP=OFF \
-DWITH_V4L=ON \
-DWITH_VTK=ON \
-DWITH_WEBP=ON \
-DWITH_XIMEA=OFF \
-DWITH_XINE=OFF \
-DCUDA_NVCC_FLAGS=--expt-relaxed-constexpr \
-DCUDA_FAST_MATH=ON \
-DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-11.6 \
-DPYTHON_DEFAULT_EXECUTABLE=$(which python3) \
-DOPENCV_DNN_CUDA=ON \
-DENABLE_FAST_MATH=ON \
-DCUDA_FAST_MATH=ON ..
print "Finish cmake"

echo "$sudo_pwd" | sudo -S make -j$(nproc)
echo "$sudo_pwd" | sudo -S make install -y
print "Finish make install"

echo "$sudo_pwd" | sudo -S /bin/bash -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'
echo "$sudo_pwd" | sudo -S /bin/bash -c 'echo "/usr/lib" >> /etc/ld.so.conf.d/opencv.conf'
echo "$sudo_pwd" | sudo -S ldconfig