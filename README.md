# PyCV2GPU

Build python opencv with gpu enabled

# For amd64 ubuntu-18.04 OpenCV-4.1.1 cuda-10.2 cudnn-8

```shell
docker pull nvidia/cuda:10.2-cudnn8-devel-ubuntu18.04
```

[//]: # (### only cuda optical flow)

[//]: # (```shell)

[//]: # (docker image build -t cv2-gpu:py3.6 -f amd64_ub18_cv4.1.1_cuda10.2_cudnn8/Dockerfile .)

[//]: # (```)

[//]: # (or cd in it)

[//]: # (```shell)

[//]: # (docker image build -t cv2-gpu:py3.6 .)

[//]: # (```)

### all cuda build

```shell
docker image build -t cv2-gpu:py3.6 -f all_gpu_acc_on/Dockerfile .
```

```shell
sudo docker image build -t cv2-gpu:py3.6 -f all_gpu_acc_on/Dockerfile .
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
sudo docker run \
  -it \
  --gpus all \
  --net=host \
  -v $(pwd):$(pwd) \
  -v /tmp/.X11-unix/:/tmp/.X11-unix:rw \
  -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
  -e DISPLAY=$DISPLAY \
  --privileged \
  --name cv2gpu_ctnr1 cv2-gpu:py3.6 /bin/bash
```

- run the container in detach

```shell
docker start cv2gpu_ctnr1
```

- enter in container

```shell
docker exec -it cv2gpu_ctnr1 bash -c "cd $(pwd) && bash"
```
