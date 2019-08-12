#!/bin/bash
#SBATCH -N 1
#SBATCH -C P100
#SBATCH -p spider
#SBATCH --exclusive
#SBATCH -t 1:00:00


ulimit -s unlimited
source ./env/setup_env_cuda10.sh 
source ./env/env_python3.sh
which python

export SCRATCH=/lus/scratch/${USER}
export CUDA_VISIBLE_DEVICES=0,1,2,3

echo "Running..."

#export TF_FP16_CONV_USE_FP32_COMPUTE=0
#export TF_FP16_MATMUL_USE_FP32_COMPUTE=0

NODES=1
NP=1
BS=32
LR0=0.000001
EPOCHS=100

TEMP_DIR=${SCRATCH}/temp/meshtf-np_${NP}-bs_${BS}-lr_${LR0}-epochs_${EPOCHS}
rm -rf $TEMP_DIR
mkdir -p ${TEMP_DIR}
cp ./mesh/examples/* ${TEMP_DIR}/
cd ${TEMP_DIR}
export SLURM_WORKING_DIR=${TEMP_DIR}

echo
echo "Settings:"
pwd
ls
echo

echo "Running..."
date
time srun --cpu_bind=rank_ldom -p spider --label -N ${NODES} -n ${NP} --cpu_bind=rank_ldom -C V100 -u --exclusive python mnist.py --batch_size ${BS} --mesh_shape="b0:${BS};b1:2;b2:2" --layout "batch:b0;row_blocks:b1;col_blocks:b2" 2>&1 |& tee myrun.out
date

echo "Done..."



