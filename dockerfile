FROM nvidia/cuda:10.1-cudnn7-devel

ENV DEBIAN_FRONTEND noninteractive

ARG OPENCV_VERSION='4.3.0'
ARG GPU_ARCH='7.5'
WORKDIR /opt

ADD 	dependencias.sh .

ADD 	intel_libs.sh .

ADD 	cmake.sh .

RUN 	sh dependencias.sh

#intel MKL IPP TBB
RUN 	sh intel_libs.sh

RUN 	apt-get install python3-pip -y

# Build OpenCV
RUN wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip && \
    unzip ${OPENCV_VERSION}.zip && rm ${OPENCV_VERSION}.zip && \
    mv opencv-${OPENCV_VERSION} OpenCV && \
    cd OpenCV && \
    wget https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip && \
    unzip 4.3.0.zip && \
    mkdir build && \
    cd build && \
    cmake \
      -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D INSTALL_PYTHON_EXAMPLES=ON \
      -D INSTALL_C_EXAMPLES=OFF \
      -D WITH_TBB=ON \
      -D TBB_DIR=/opt/intel/tbb \
      -D WITH_CUDA=ON \
      -D WITH_MKL=ON \
      -D MKL_USE_MULTITHREAD=ON \
      -D MKL_WITH_TBB=ON \
      -D MKL_INCLUDE_DIRS=/opt/intel/mkl/include \
      -D MKL_ROOT_DIR=/opt/intel/mkl \
      -D CUDA_ARCH_BIN=${GPU_ARCH} \
      -D CUDA_ARCH_PTX=${GPU_ARCH} \
      -D BUILD_opencv_cudacodec=OFF \
      -D WITH_CUBLAS=1 \
      -D WITH_CUFFT=ON \
      -D WITH_NVCUVID=OFF \
      -D WITH_EIGEN=ON \
      -D EIGEN_INCLUDE_PATH=/usr/include/eigen3 \
      -D WITH_V4L=ON \
      -D WITH_QT=OFF \
      -D WITH_OPENGL=ON \
      -D WITH_GSTREAMER=ON \
      -D OPENCV_GENERATE_PKGCONFIG=ON \
      -D OPENCV_ENABLE_NONFREE=ON \
      -D OPENCV_EXTRA_MODULES_PATH=../opencv_contrib-4.3.0/modules \
      -D BUILD_EXAMPLES=ON \
      .. && \
    make all -j$(nproc) && \
    make install


#build MXNET
RUN 	sh cmake.sh

RUN cd /opt && \
    git clone -b v1.6.x --recursive https://github.com/apache/incubator-mxnet.git mxnet && \
    cd /opt/mxnet && \
    git checkout tags/1.6.0 && \
    #cp config/linux_gpu.cmake config.cmake && \
    rm -rf build && \
    mkdir -p build && cd build && \
    cmake \
      -D USE_CUDA=1 \
      -D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-10.1 \
      -D MXNET_CUDA_ARCH=7.5 \
      -D USE_CUDNN=1 \
      -D CMAKE_BUILD_TYPE=Release \
      -D BLAS=MKL \
      -D USE_OPENCV=1 \
      -D USE_OPENMP=0 \
      -D DNNL_CPU_RUNTIME=TBB \
      -D MKL_ROOT=/opt/intel/mkl \
      -D USE_BLAS=MKL \
      -D USE_GPERFTOOLS=1 \
      -D USE_INT64_TENSOR_SIZE=1 \
      -D USE_LAPACK=0 \
      -D USE_MKLDNN=0 \
      -D USE_MKL_IF_AVAILABLE=1 \
      -D MKL_USE_ILP64=1 \
      -D USE_JEMALLOC=0 \
      -D MKL_USE_SINGLE_DYNAMIC_LIBRARY=1 \
      -D MKL_USE_STATIC_LIBS=0 \
      -D MKL_MULTI_THREADED=1 \
      -D MKL_INCLUDE_DIR=/opt/intel/mkl/include \
      -D TBBROOT=/opt/intel/tbb \
      .. && \
    make all -j$(nproc) && \
    make install && \
    cd ../python && \
    pip3 install -e .
