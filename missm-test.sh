#!/bin/bash
module load mpich-3.0.3-R
module load cmake-2.8.10
module load qt-4.8.2
module load ninja
ctest -S /work3/visit-branch/dashboard/missm-config.cmake -O missm-test.log -V
