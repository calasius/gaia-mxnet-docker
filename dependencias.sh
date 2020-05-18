#dependencias
apt update && \
    apt-get install -y apt-utils

# Build tools
apt update && \
    apt install -y \
    sudo \
    tzdata \
    git \
    cmake \
    wget \
    unzip \
    build-essential \
    pkg-config


# Media I/O:
sudo apt install -y \
    zlib1g-dev \
    libjpeg-dev \
    libwebp-dev \
    libpng-dev \
    libtiff5-dev \
    libopenexr-dev \
    libgdal-dev \
    libgtk-3-dev \
    libtesseract-dev \
    openexr

# Video I/O:
sudo apt install -y \
    libdc1394-22 \
    libdc1394-22-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libtheora-dev \
    libvorbis-dev \
    libxvidcore-dev \
    x264 \
    libx264-dev \
    libfaac-dev \
    libmp3lame-dev \
    libavresample-dev \
    yasm \
    libopencore-amrnb-dev \
    libopencore-amrwb-dev \
    libv4l-dev \
    v4l-utils \
    libxine2-dev \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev

# Parallelism and linear algebra libraries:
sudo apt install -y \
    libtbb2 \
    libtbb-dev \
    libeigen3-dev \
    libatlas-base-dev \
    gfortran

#Cameras programming interface libs
cd /usr/include/linux
sudo ln -s -f ../libv4l1-videodev.h videodev.h
cd ~

#optional libs
sudo apt-get install -y libprotobuf-dev protobuf-compiler
sudo apt-get install -y libgoogle-glog-dev libgflags-dev
sudo apt-get install -y libgphoto2-dev libhdf5-dev doxygen


# Python:
sudo apt install -y \
    python3-dev \
    python3-tk \
    python3-numpy
