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
wget https://github.com/opencv/opencv/archive/refs/tags/4.1.1.zip
```
