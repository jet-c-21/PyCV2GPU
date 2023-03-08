FROM nvidia/cuda:10.1-cudnn8-devel-ubuntu18.04
ARG PYTHON_VERSION=3.6
ARG OPENCV_VERSION=4.1.1
ARG HOST_XDG_RUNTIME_DIR=/run/user/1000

# Set SHELL to bash
SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=US/Pacific

RUN mkdir -p $HOST_XDG_RUNTIME_DIR && chmod 700 $HOST_XDG_RUNTIME_DIR

RUN \
    # add sources for older pythons
    apt-get update -qq --fix-missing && \
    apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-add-repository universe && \
    apt-get -y update -qq --fix-missing && \
    apt-get -y install --no-install-recommends \
        python${PYTHON_VERSION} \
        python${PYTHON_VERSION}-dev \
        $( [ ${PYTHON_VERSION%%.*} -ge 3 ] && echo "python${PYTHON_VERSION}-distutils" ) \
        wget \
    && \
    # Set the default python and install PIP packages
    update-alternatives --install /usr/bin/python${PYTHON_VERSION%%.*} python${PYTHON_VERSION%%.*} /usr/bin/python${PYTHON_VERSION} 1 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python${PYTHON_VERSION} 1 && \
    # install python dependencies
    # sysctl -w net.ipv4.ip_forward=1 ; \
    if [[ "$PYTHON_VERSION" == "2.7" || "$PYTHON_VERSION" == "3.6" ]]; then \
        wget https://bootstrap.pypa.io/pip/$PYTHON_VERSION/get-pip.py --progress=bar:force:noscroll --no-check-certificate ; \
    else \
        apt-get -y install --no-install-recommends python${PYTHON_VERSION}-distutils ; \
        wget https://bootstrap.pypa.io/get-pip.py --progress=bar:force:noscroll --no-check-certificate ; \
    fi && \
    python${PYTHON_VERSION} get-pip.py && \
    rm get-pip.py && \
    rm -rf /var/lib/apt/lists/*

ENV PYTHONPATH="/usr/lib/python${PYTHON_VERSION}/site-packages:/usr/local/lib/python${PYTHON_VERSION}/site-packages"

# install some tools
RUN apt-get update && apt-get install -y \
    git \
    iputils-ping \
    curl \
    wget

# install gstreamer
RUN apt-get update && apt-get install -y \
  libgstreamer1.0-dev \
  libgstreamer-plugins-base1.0-dev \
  libgstreamer-plugins-bad1.0-dev \
  gstreamer1.0-plugins-base \
  gstreamer1.0-plugins-good \
  gstreamer1.0-plugins-bad \
  gstreamer1.0-plugins-ugly \
  gstreamer1.0-libav \
  gstreamer1.0-tools \
  gstreamer1.0-x \
  gstreamer1.0-alsa \
  gstreamer1.0-gl \
  gstreamer1.0-gtk3 \
  gstreamer1.0-qt5 \
  gstreamer1.0-pulseaudio


RUN \
    # Add CUDA libs paths
    CUDA_PATH=(/usr/local/cuda-*) && \
    CUDA=`basename $CUDA_PATH` && \
    echo "$CUDA_PATH/compat" >> /etc/ld.so.conf.d/${CUDA/./-}.conf && \
    ldconfig && \
# Install all dependencies for OpenCV
    apt-get -y update -qq --fix-missing && \
    apt-get -y install --no-install-recommends \
        unzip \
        cmake \
        ffmpeg \
        libtbb2 \
        gfortran \
        apt-utils \
        pkg-config \
        checkinstall \
        qt5-default \
        build-essential \
        libopenblas-base \
        libopenblas-dev \
        liblapack-dev \
        libatlas-base-dev \
        #libgtk-3-dev \
        #libavcodec58 \
        libavcodec-dev \
        #libavformat58 \
        libavformat-dev \
        libavutil-dev \
        #libswscale5 \
        libswscale-dev \
        libjpeg8-dev \
        libpng-dev \
        libtiff5-dev \
        #libdc1394-22 \
        libdc1394-22-dev \
        libxine2-dev \
        libv4l-dev \
        libgstreamer1.0 \
        libgstreamer1.0-dev \
        libgstreamer-plugins-base1.0-0 \
        libgstreamer-plugins-base1.0-dev \
        libglew-dev \
        libpostproc-dev \
        libeigen3-dev \
        libtbb-dev \
        zlib1g-dev \
        libsm6 \
        libxext6 \
        libxrender1 \
    && \
    pip${PYTHON_VERSION} install numpy && \
# Install OpenCV
    wget https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip -O opencv.zip --progress=bar:force:noscroll && \
    unzip -q opencv.zip && \
    mv /opencv-$OPENCV_VERSION /opencv && \
    rm opencv.zip && \
    wget https://github.com/opencv/opencv_contrib/archive/$OPENCV_VERSION.zip -O opencv_contrib.zip --progress=bar:force:noscroll && \
    unzip -q opencv_contrib.zip && \
    mv /opencv_contrib-$OPENCV_VERSION /opencv_contrib && \
    rm opencv_contrib.zip && \
# Prepare build
    mkdir /opencv/build && \
    cd /opencv/build && \
    cmake \
      -D CMAKE_BUILD_TYPE=RELEASE \
      -D BUILD_PYTHON_SUPPORT=ON \
      -D BUILD_DOCS=ON \
      -D BUILD_PERF_TESTS=OFF \
      -D BUILD_TESTS=OFF \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D OPENCV_EXTRA_MODULES_PATH=/opencv_contrib/modules \
      -D BUILD_opencv_python3=$( [ ${PYTHON_VERSION%%.*} -ge 3 ] && echo "ON" || echo "OFF" ) \
      -D BUILD_opencv_python2=$( [ ${PYTHON_VERSION%%.*} -lt 3 ] && echo "ON" || echo "OFF" ) \
      -D PYTHON${PYTHON_VERSION%%.*}_EXECUTABLE=$(which python${PYTHON_VERSION}) \
      -D PYTHON_DEFAULT_EXECUTABLE=$(which python${PYTHON_VERSION}) \
      -D BUILD_EXAMPLES=OFF \
      -D WITH_IPP=OFF \
      -D WITH_FFMPEG=ON \
      -D WITH_GSTREAMER=ON \
      -D WITH_V4L=ON \
      -D WITH_LIBV4L=ON \
      -D WITH_TBB=ON \
      -D WITH_QT=ON \
      -D WITH_OPENGL=ON \
      -D WITH_CUDA=ON \
      -D WITH_CUDNN=ON \
      -D WITH_LAPACK=ON \
      #-D WITH_HPX=ON \
      -D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda \
      -D CMAKE_LIBRARY_PATH=/usr/local/cuda/lib64/stubs \
      # https://kezunlin.me/post/6580691f
      # https://stackoverflow.com/questions/28010399/build-opencv-with-cuda-support
      -D CUDA_ARCH_BIN="6.1 7.5" \
      -D CUDA_ARCH_PTX="" \
      -D WITH_CUBLAS=ON \
      -D WITH_NVCUVID=ON \
      -D ENABLE_FAST_MATH=1 \
      -D CUDA_FAST_MATH=1 \
      -D BUILD_opencv_cudaoptflow=ON \
      -D BUILD_opencv_cudacodec=ON \
      -D BUILD_opencv_cudev=ON \
      -D BUILD_opencv_cudaarithm=ON \
      -D BUILD_opencv_cudafeatures2d=ON \
      -D BUILD_opencv_cudafilters=ON \
      -D BUILD_opencv_cudaimgproc=ON \
      -D BUILD_opencv_cudaobjdetect=ON \
      -D BUILD_opencv_cudastereo=ON \
      -D BUILD_opencv_cudawarping=ON \
      -D BUILD_opencv_cudacnn=ON \
      -D BUILD_opencv_cudabgsegm=ON \
      -D BUILD_opencv_cudastitching=ON \
#      -D BUILD_opencv_world=OFF \
      -D ENABLE_PRECOMPILED_HEADERS=OFF \
      .. \
    && \
# Build, Test and Install
    cd /opencv/build && \
    make -j$(nproc) && \
    make install && \
    ldconfig && \
    rm -rf /opencv /opencv_contrib /var/lib/apt/lists/* && \
# Call default command.
    ffmpeg -version && \
    #ldd `which ffmpeg` && \
    python --version && \
    python -c "import cv2 ; print(cv2.__version__)"
