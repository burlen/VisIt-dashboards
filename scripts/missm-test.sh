#!/bin/bash -l
module load mpich-3.0.3-R
module load cmake-2.8.10
module load qt-4.8.2
export DISPLAY=:0
if [[ $# != 1 ]]
then
    echo
    echo "ERROR: Usage"
    echo "$0 Experimental|Nightly|Continuous"
    echo
    exit -1
fi
export DASHBOARD_TYPE=$1
EPOCH=`date +%s`
cd /work2/visit-branch/dashboard
ctest -S /work2/visit-branch/dashboard/missm-config.cmake -O ./logs/$DASHBOARD_TYPE-$EPOCH.log -V
find /work2/visit-branch/dashboard/logs -maxdepth 0 -name '*.log' -atime 2 -exec rm \{\} \;
