#!/bin/bash

module load java
module list

export SWIG_PATH=../Tools/swig/bin/swig
export BAZEL_PATH=../Tools/bazel/bin_new/lib/bazel/bin

export PATH=${SWIG_PATH}:${BAZEL_PATH}:${PATH}
#export LD_LIBRARY_PATH=${BAZEL_PATH}/lib:${LD_LIBRARY_PATH}
#Bazel might need to use a temp directory instead of the default ~/.cache/bazel
export TEST_TMPDIR=/tmp/mybazeltempdir

bazel version
