#!/bin/bash -l
module load mpich-3.0.3-R
module load cmake-2.8.10
module load qt-4.8.2
logfileId=`date +%s`
cd /work3/visit-branch/dashboard
ctest -S /work3/visit-branch/dashboard/missm-config.cmake -O missm-test-$logfileId.log -V
find /work3/visit-branch/dashboard -name 'missm-test*.log' -atime 3 -exec rm \{\} \;
