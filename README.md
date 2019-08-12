# mesh-transformer-mpi

This repo is to track progress of building Tensorflow with MPI support.

The goal is to ensure Tensorflow maps network communication operations to MPI calls, such that the ops used by mesh-tensorflow get mapped to MPI calls as well.

./common-problems.txt:  Common problems I've hit while trying to against MPI. Directions to changing tensorflow/configure.py
./tests:                Tests for making sure calls are actually using mpi
./runscripts:           Launch scripts for Mesh-Tensorflow


Step 1) Setup Configure

    -> git clone tensorflow
    -> git checkout r1.13
    -> If using Cray-MPICH, cp configure.py tensorflow/
    -> If using OpenMPI, use default configure.py

Step 2) Build it

    -> Edit the paths in buildit.sh to point to the correct MPI dirs and bazel temp dirs
    -> run buildit.sh like: ./buildit.sh
    -> Answer the questions about the path to Python
    -> Answer Yes (y) to the question regarding MPI build support, no additional input should be required for that item if you setup the path correctly

Step 3) Fix common issues are having undeclared dependencies for MPI headers 
    -> Most can be fixed by editing the bazel build files:
        -> tensorflow/contrib/mpi/BUILD 
        -> tensorflow/contrib/mpi_collectives/BUILD 
    -> Declare dependencies where needed. This has only been necessary when headers outside of mpi.h are required (e.g. MPICH)

Step 4) Once the build completes, do:
    -> pip install mesh-tensorflow --user
    -> cd /tests
    -> Edit runit.sh to point to the correct directories (requires srun / SLURM)
    -> If you build on Cray XC, the perftools-lite module should be loaded
    -> Once the test run completes, perftools should produce a profile which shows MPI calls map to tensorflow ops

       




