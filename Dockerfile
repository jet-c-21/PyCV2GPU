# Base image
FROM nvidia/cuda:11.6.0-cudnn8-devel-ubuntu18.04

# Set environment variables
ENV OPENCV_VERSION 4.5.5
ENV PYTHON_VERSION 3.6.9

# Set timezone to US and UTC+8
RUN ln -sf /usr/share/zoneinfo/US/Pacific /etc/localtime && \
    echo "US/Pacific" > /etc/timezone

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    wget \
    unzip \
    libopencv-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libgtk2.0-dev \
    python3-dev \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip3 install numpy

# Download and extract opencv_contrib repository
RUN wget https://github.com/opencv/opencv_contrib/archive/$OPENCV_VERSION.zip && \
    unzip $OPENCV_VERSION.zip && \
    rm $OPENCV_VERSION.zip && \
    mv opencv_contrib-$OPENCV_VERSION opencv_contrib

# Download and build OpenCV with CUDA support
RUN wget https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip && \
    unzip $OPENCV_VERSION.zip && \
    rm $OPENCV_VERSION.zip && \
    mkdir -p opencv-$OPENCV_VERSION/build && \
    cd opencv-$OPENCV_VERSION/build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
          -D CMAKE_INSTALL_PREFIX=/usr/local \
          -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
          -D WITH_CUDA=ON \
          -D CUDA_ARCH_BIN=6.1 \
          -D CUDA_ARCH_PTX="" \
          -D BUILD_opencv_cudacodec=OFF \
          -D BUILD_opencv_python3=ON \
          -D BUILD_opencv_python2=OFF \
          -D BUILD_opencv_java=OFF \
          -D BUILD_opencv_world=OFF \
          .. && \
    make -j$(nproc) && \
    make install && \
    ldconfig && \
    cd ../.. && \
    rm -rf opencv-$OPENCV_VERSION opencv_contrib

# Set Python path
ENV PYTHONPATH /usr/local/lib/python$PYTHON_VERSION/dist-packages

# Verify installation
RUN python3 -c 'import cv2; print(cv2.cuda.getCudaEnabledDeviceCount())'

# Set the working directory
WORKDIR /app

# Copy the rest of the application files
COPY . .

# Start the application
CMD [ "python3", "app.py" ]
