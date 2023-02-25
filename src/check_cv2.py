# coding: utf-8
"""
Author: Jet C.
GitHub: https://github.com/jet-c-21
Create Date: 2023-02-25
"""
import pathlib
import cv2

print(cv2.__file__)
print(cv2.__version__)
print(cv2.getBuildInformation())
print(cv2.cuda.getCudaEnabledDeviceCount())
cap = cv2.VideoCapture(0)
print(cap.isOpened())
