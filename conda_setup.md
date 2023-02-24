# Environment

### Create conda env
```shell
conda create -y --name=cv2gpu python=3.6.9 
```

### Remove conda env
```shell
conda env remove -y --name cv2gpu 
```

### add jupyter kernel
```shell
conda activate cv2gpu
pip install ipykernel
python -m ipykernel install --user --name cv2gpu --display-name "CV2 GPU"
```

### remove jupyter kernel
```shell
jupyter kernelspec uninstall -y cv2gpu 
```

### Fix CV2 import problem
```shell
rm /home/puff/anaconda3/envs/cv2gpu/lib/libstdc++.so.6
ln -s /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /home/puff/anaconda3/envs/cv2gpu/lib/libstdc++.so.6
```

# Build Step

### Install necessary dependencies: Install the necessary dependencies for building OpenCV with GPU CUDA support using the following command
```shell
conda install -y -c anaconda cmake numpy matplotlib scikit-image scikit-learn
conda install -y -c conda-forge ffmpeg
```

### Install OpenCV src code
```shell
opencv_src_file=opencv.zip
opencv_src_url=https://github.com/opencv/opencv/archive/refs/tags/4.1.1.zip
wget $opencv_src_url -O $opencv_src_file
echo "Finish download $opencv_src_file"
unzip -q $opencv_src_file
echo "Finish unzip $opencv_src_file"
rm -f $opencv_src_file
```

### Build
```shell
cd opencv*
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D INSTALL_PYTHON_EXAMPLES=ON \
      -D OPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules \
      -D WITH_CUDA=ON \
      -D CUDA_ARCH_BIN=7.5 \
      -D CUDA_ARCH_PTX="" \
      -D ENABLE_FAST_MATH=1 \
      -D CUDA_FAST_MATH=1 \
      -D WITH_CUBLAS=1 \
      -D WITH_TBB=ON \
      -D WITH_FFMPEG=ON \
      -D WITH_GSTREAMER=ON \
      -D WITH_XINE=ON \
      -D BUILD_EXAMPLES=ON ..
```
