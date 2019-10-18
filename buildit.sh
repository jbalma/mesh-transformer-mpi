#!/bin/bash
source ./env/setup_env_cuda10.sh 
source ./env/env_python3.sh
source ./env/setup_bazel_env.sh



module list
#Bazel might need to use a temp directory instead of the default ~/.cache/bazel
export TEST_TMPDIR=${PWD}/tmp/bazelstuff
rm -rf $TEST_TMPDIR 
mkdir $TEST_TMPDIR
export MPI_HOME=${CRAY_MPICH_BASEDIR}/mpich-gnu/8.2

git clone https://github.com/tensorflow/tensorflow.git
cd tensorflow
git checkout r1.15

bazel shutdown
bazel clean
#CUDA_HOME=/path_to_cuda/cuda
#CUDNN_HOME=/path_to_cudnn/cudnn-10.0-v742/cuda/lib64
echo using mpi base dir: $MPI_HOME
echo set the python path to: $PYTHONUSERBASE/lib/python3.6/site-packages 
echo cudadnn base dir: $CUDNN_HOME
echo cuda home: $CUDA_HOME
echo using gcc from: 
which gcc 

./configure --workspace=tensorflow/
#./configure 



#GPU VERSION
#===========================================
#bazel build --config=cuda --action_env GCC_HOST_COMPILER_PATH="/opt/gcc/8.3.0/bin/gcc" --copt=-fexceptions --cxxopt=-fexceptions --cxxopt="-DEIGEN_HAS_CXX11_NOEXCEPT=0" --copt="-DMPICH_SKIP_MPICXX=1" --cxxopt="-DMPICH_SKIP_MPICXX=1" --copt="-DEIGEN_HAS_CXX11_NOEXCEPT=0" --verbose_failures  --cxxopt="-D_GLIBCXX_USE_CXX11_ABI=0" --copt=-mavx --copt=-msse4.1 --copt=-msse4.2 --copt=-mavx2 --copt=-mfma --copt=-mfpmath=both //tensorflow/tools/pip_package:build_pip_package 2>&1 |& tee build.log

#CPU VERSION
bazel build --action_env GCC_HOST_COMPILER_PATH="/opt/gcc/8.3.0/bin/gcc" --copt=-fexceptions --cxxopt=-fexceptions --cxxopt="-DEIGEN_HAS_CXX11_NOEXCEPT=0" --copt="-DMPICH_SKIP_MPICXX=1" --cxxopt="-DMPICH_SKIP_MPICXX=1" --copt="-DEIGEN_HAS_CXX11_NOEXCEPT=0" --verbose_failures  --cxxopt="-D_GLIBCXX_USE_CXX11_ABI=0" --copt=-mavx --copt=-msse4.1 --copt=-msse4.2 --copt=-mavx2 --copt=-mfma --copt=-mfpmath=both //tensorflow/tools/pip_package:build_pip_package 2>&1 |& tee build.log

bazel-bin/tensorflow/tools/pip_package/build_pip_package ${TEST_TMPDIR}/tmp_tiger.12345
#pip install /tmp/tensorflow_pkg/tensorflow-0.6.0-cp27-none-linux_x86_64.whl
echo "Done!, check /cray/css/users/jbalma/tmp/tmp_tiger.12345"

