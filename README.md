# PyCV2GPU

### [Dockerfile Ref from @Borda](https://github.com/Borda/docker_python-opencv-ffmpeg/blob/master/gpu/Dockerfile)

Build python opencv with gpu enabled

# For ubuntu-18.04 OpenCV-4.1.1 cuda-10.1 cudnn-8

### all cuda build

```shell
docker image build \
  --build-arg HOST_XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
  -t cv2-gpu:v6 -f cuda10.1-cudnn8-devel-ubuntu18.04/Dockerfile .
```

##### Failed with darknet

```shell
docker image build \
  --build-arg HOST_XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
  -t nd-cv2-gpu:v1 -f darknet_failed_all_gpu_acc_on/Dockerfile .
```

or cd in it

```shell
docker image build -t cv2-gpu:py3.6 .
```

```shell
sudo docker image build -t cv2-gpu:py3.6 .
```

### Container create

- create container

```shell
docker run \
  -it \
  --gpus all \
  --net=host \
  -v $(pwd):$(pwd) \
  -v /tmp/.X11-unix/:/tmp/.X11-unix \
  -v /tmp/.docker.xauth:/tmp/.docker.xauth \
  -v $(XDG_RUNTIME_DIR):$(XDG_RUNTIME_DIR) \
  -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
  -e XAUTHORITY=/tmp/.docker.xauth \
  -e DISPLAY=$DISPLAY \
  -w $(pwd) \
  --privileged \
  --name cv2gpu_ctnr1 cv2-gpu:py3.6
```

- run the container in detach

```shell
docker start cv2gpu_ctnr1
```

- enter in container

```shell
docker exec -it cv2gpu_ctnr1 bash -c "cd $(pwd) && bash"
```

# For ubuntu-20.04 OpenCV-4.7.0 cuda-11.7.1 cudnn-8 (CUDA Capability up to 8.9)
```shell
docker image build \
  --build-arg HOST_XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
  -t cv2-gpu:cc8.9 -f cuda11.7.1-cudnn8-devel-ubuntu20.04/Dockerfile .
```
