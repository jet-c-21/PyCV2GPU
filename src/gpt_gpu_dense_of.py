# coding: utf-8
"""
Author: Jet C.
GitHub: https://github.com/jet-c-21
Create Date: 2023-02-27
"""
import pathlib
import sys
import cv2
import datetime

# Create the Farneback optical flow object
flow = cv2.cuda_FarnebackOpticalFlow.create()

frame_1_path = '../Images/frame_1.jpg'
frame_2_path = '../Images/frame_2.jpg'

frame_1 = cv2.imread(frame_1_path)
frame_2 = cv2.imread(frame_2_path)

st = datetime.datetime.now()

# Convert the frames to grayscale
frame_1_gray = cv2.cvtColor(frame_1, cv2.COLOR_BGR2GRAY)
frame_2_gray = cv2.cvtColor(frame_2, cv2.COLOR_BGR2GRAY)

# Upload the frames to the GPU
frame_1_gpu = cv2.cuda_GpuMat(frame_1_gray)
frame_2_gpu = cv2.cuda_GpuMat(frame_2_gray)

cal_st = datetime.datetime.now()

# Calculate optical flow between the two frames
flow_gpu = flow.calc(frame_1_gpu, frame_2_gpu, None)

# Download the optical flow back to the CPU
flow_cpu = flow_gpu.download()
print(f"flow_cpu.shape = {flow_cpu.shape}")

cal_ed = datetime.datetime.now()

cal_cost = cal_ed - cal_st
print(f"Cal Cost: {cal_cost}, sec = {cal_cost.total_seconds()}")

# Convert the optical flow to a grayscale image
flow_magnitude, flow_angle = cv2.cartToPolar(flow_cpu[..., 0], flow_cpu[..., 1])
flow_magnitude_normalized = cv2.normalize(flow_magnitude, None, 0, 255, cv2.NORM_MINMAX)
flow_gray = cv2.convertScaleAbs(flow_magnitude_normalized)

print(f"flow_color.shape = {flow_gray.shape}")

output_image_path = '../Images/gpu_flow.jpg'
cv2.imwrite(output_image_path, flow_gray)
ed = datetime.datetime.now()

cost = ed - st
print(cost.total_seconds())
