docker run \
  -it \
  --rm \
  --privileged \
  --gpus all \
  --device /dev/video0:/dev/video0 \
  --net=host \
  -e DISPLAY=$DISPLAY \
  --name cv2gpu_ctnr1 cv2-gpu:py3.6 /bin/bash