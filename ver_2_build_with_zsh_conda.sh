#!/bin/bash

# Ask user to type sudo password
echo "Please enter your sudo password:"
#read -s sudo_pwd

clear
sudo_pwd=1130

# Update packages with sudo
#echo "$sudo_pwd" | sudo -S apt-get update

source ./color_print.sh

eval "$(conda shell.bash hook)"
conda activate cv2gpu
print "Current Cond ENV: "
