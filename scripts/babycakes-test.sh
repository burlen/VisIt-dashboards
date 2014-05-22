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
if [[ -e $LOCKFILE ]]
then
    echo
    echo "ERROR: Found lockfile $LOCKFILE"
    echo "ERROR: Won't start another run while one is already running "
    echo
    exit -2
fi
touch $LOCKFILE
ctest --timeout 120 -S /Users/bloring/visit/dashboards/babycakes-config.cmake -O ./logs/$DASHBOARD_TYPE-$EPOCH.log -V
find /Users/bloring/visit/dashboards/logs -maxdepth 0 -name '*.log' -atime 2 -exec rm \{\} \;
rm $LOCKFILE
