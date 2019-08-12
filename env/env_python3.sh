#!/bin/bash
#module load cray-python
module load anaconda3
export SWIG_PATH=/path/to/swig/bin
export BAZEL_PATH=/path/to/bazel
#Bazel might need to use a temp directory instead of the default ~/.cache/bazel

. /path/to/anaconda3/etc/profile.d/conda.sh
#conda init bash
#export PYTHONPATH="${PYTHONUSERBASE}/lib/python3.6/site-packages:$PYTHONPATH"
export PYTHONIOENCODING=utf8
export PYTHONPATH="$PY3PATH:$PYTHONPATH"
export PATH=${SWIG_PATH}:${BAZEL_PATH}:${PATH}



