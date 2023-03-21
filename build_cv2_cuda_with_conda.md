```shell
sudo apt update && sudo apt upgrade -y
```
```shell
sudo apt install -y build-essential cmake pkg-config gcc g++ && \
sudo apt install -y libpng-dev libjpeg-dev libopenexr-dev libtiff-dev libwebp-dev libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev && \
sudo apt install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev && \
sudo apt install -y libxvidcore-dev libx264-dev libgtk-3-dev && \
sudo apt install -y libatlas-base-dev gfortran
```
```shell
sudo apt install -y libopenblas-dev liblapack-dev libeigen3-dev libtheora-dev libvorbis-dev sphinx-common && \
sudo apt install -y libtbb-dev yasm libopencore-amrnb-dev libopencore-amrwb-dev libopenexr-dev libgstreamer-plugins-base1.0-dev && \
sudo apt install -y libavutil-dev libavfilter-dev ffmpeg
```
```shell
OPENCV_VER=4.1.1 && \
OPENCV_BUILD_DIR=opencv_build && \
mkdir -p ${OPENCV_BUILD_DIR} && cd ${OPENCV_BUILD_DIR} && \
wget "https://github.com/opencv/opencv/archive/${OPENCV_VER}.zip" -O opencv.zip && \
wget "https://github.com/opencv/opencv_contrib/archive/${OPENCV_VER}.zip" -O opencv_contrib.zip && \
unzip opencv.zip && \
unzip opencv_contrib.zip && \
rm -f *.zip
```
```shell
conda create -y -n bts python=3.6.9 && conda activate bts
```
```shell
export python_exec=`which python` && \
export include_dir=`python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())"` && \
export library=`python -c "import distutils.sysconfig as sysconfig; print(sysconfig.get_config_var('LIBDIR'))"` && \
export default_exec=`which python3.6`
```
be sure you are in `opencv_build/opencv-x.x.x`
```shell
mkdir build && cd build && \
cmake \
-D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_INSTALL_PREFIX=/usr/local \
-D WITH_CUDA=ON \
-D ENABLE_FAST_MATH=1 \
-D CUDA_FAST_MATH=1 \
-D CUDA_ARCH_BIN="6.1 7.5" \
-D CUDA_ARCH_PTX="" \
-D WITH_CUBLAS=1 \
-D INSTALL_PYTHON_EXAMPLES=ON \
-D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-${OPENCV_VER}/modules \
-D PYTHON_EXECUTABLE=$python_exec \
-D PYTHON_DEFAULT_EXECUTABLE=$default_exec \
-D PYTHON_INCLUDE_DIRS=$include_dir \
-D PYTHON_LIBRARY=$library \
-D EIGEN_INCLUDE_PATH=/usr/include/eigen3 \
-D BUILD_EXAMPLES=ON ..
```
```shell
make -j4 && \
sudo make install && \
sudo ldconfig
```