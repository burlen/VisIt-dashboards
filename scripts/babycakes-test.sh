#!/bin/bash -l
if [[ $# != 1 ]]
then
    echo
    echo "ERROR: Usage"
    echo "$0 Experimental|Nightly|Continuous"
    echo
    exit -1
fi
source /Users/bloring/openmpi-1.6.4.sh
export DASHBOARD_TYPE=$1
EPOCH=`date +%s`
ctest -S /Users/bloring/visit/dashboards/babycakes-config.cmake -O ./logs/$DASHBOARD_TYPE-$EPOCH.log -V
find /Users/bloring/visit/dashboards/logs -maxdepth 0 -name '*.log' -atime 2 -exec rm \{\} \;
