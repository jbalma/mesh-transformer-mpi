#!/bin/bash
module rm PrgEnv-cray 
module load PrgEnv-gnu
#module rm gcc
#module load gcc/8.3.0
export GNU_VERSION=8.3.0
module load craype-accel-nvidia70
#module rm ugni
#module rm atp
module swap cudatoolkit cudatoolkit/10.0.130_3.22-7.0.1.0_5.2__gdfb4ce5
#CUDNN_HOME=path/to/CuDNN/cudnn-10.0-v742/cuda 
export CUDA_HOME=${CUDATOOLKIT_HOME}
export CUDNN_PATH=/path/to/cudnn-10.0-v742/cuda 
export PATH=${CRAY_MPICH}/bin:${PATH}
export LD_LIBRARY_PATH=${CUDNN_PATH}/lib64:${CRAY_LD_LIBRARY_PATH}:${LD_LIBRARY_PATH}
export C_INCLUDE_PATH=${CUDA_HOME}/include:${C_INCLUDE_PATH}
#need this for libcuda.so on some systems
export LD_LIBRARY_PATH=/opt/cray/nvidia/default/lib64:${LD_LIBRARY_PATH}

module list

