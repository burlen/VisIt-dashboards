#!/bin/bash -l
if [[ $# != 2 ]]
then
    echo
    echo "ERROR: Usage"
    echo "$0 Experimental|Nightly|Continuous asan|basic"
    echo
    exit -1
fi


module load mpich/3.1-rc1
export ASAN_SYMBOLIZER_PATH=`which llvm-symbolizer`
export DISPLAY=:0

DASHROOT=/work/dashboards/visit
cd $DASHROOT
export LD_LIBRARY_PATH=$DASHROOT/visit-deps/visit/vtk/6.1.0/x86_64/lib:$LD_LIBRARY_PATH
export DISPLAY=:0
export DASHBOARD_TYPE=$1
LOCKFILE=lock_$DASHBOARD_TYPE
if [[ -e $LOCKFILE ]]
then
    echo
    echo "ERROR: Found lockfile $LOCKFILE"
    echo "ERROR: Won't start another run while one is already running"
    echo
    exit -2
fi
touch $LOCKFILE
trap "rm -f $LOCKFILE; exit" SIGHUP SIGINT SIGTERM
EPOCH=`date +%s`
ctest --timeout 120 -S ${DASHROOT}/rocky-config.cmake -O ./logs/$DASHBOARD_TYPE-$EPOCH.log -V
find ${DASHROOT}/logs -maxdepth 0 -name '*.log' -atime 2 -exec rm \{\} \;
rm $LOCKFILE
