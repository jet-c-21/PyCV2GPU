# PyCV2GPU

Build python opencv with gpu enabled

# For amd64 ubuntu-18.04 OpenCV-4.1.1 cuda-10.2 cudnn-8

### all cuda build

```shell
docker image build \
  --build-arg HOST_XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
  -t cv2-gpu:v5 -f cuda10.1-cudnn8-devel-ubuntu18.04/Dockerfile .
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
