# Environment

### Python ```3.6.9```, Opencv ```4.1.1```

### Create conda env
```shell
conda create --name=cv2gpu python=3.6.9 -y 
```

### Remove conda env
```shell
conda env remove --name cv2gpu -y
```

### add jupyter kernel
```shell
conda activate cv2gpu
pip install ipykernel
python -m ipykernel install --user --name cv2gpu --display-name "CV2 GPU"
```

### remove jupyter kernel
```shell
jupyter kernelspec uninstall cv2gpu -y
```

### Fix CV2 import problem
```shell
rm /home/puff/anaconda3/envs/cv2gpu/lib/libstdc++.so.6
ln -s /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /home/puff/anaconda3/envs/cv2gpu/lib/libstdc++.so.6
```

# Build Step

### Install necessary dependencies: Install the necessary dependencies for building OpenCV with GPU CUDA support using the following command
```shell
conda install -c anaconda cmake numpy matplotlib scikit-image scikit-learn
conda install -c conda-forge ffmpeg
```
