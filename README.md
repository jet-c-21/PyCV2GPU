# PyCV2GPU
Build python opencv with gpu enabled

# For amd64 ubuntu-18.04 OpenCV-4.1.1 cuda-10.2 cudnn-8
```shell
docker pull nvidia/cuda:10.2-cudnn8-devel-ubuntu18.04
```

### only cuda optical flow
```shell
docker image build -t cv2-gpu:py3.6 -f amd64_ub18_cv4.1.1_cuda10.2_cudnn8/Dockerfile .
```
or cd in it
```shell
docker image build -t cv2-gpu:py3.6 .
```

### all cuda build
```shell
docker image build -t cv2-gpu-all-cuda:py3.6 -f all_gpu_acc_on/Dockerfile .
```
or cd in it
```shell
docker image build -t cv2-gpu-all-cuda:py3.6 .
```
