#!/bin/bash -l
if [[ $# != 2 ]]
then
    echo
    echo "ERROR: Usage"
    echo "$0 Experimental|Nightly|Continuous clang|gcc"
    echo
    exit -1
fi
case "$2" in
    gcc)
      DASHCONFIG=babycakes-config.cmake
      source /Users/bloring/openmpi-1.6.4.sh
      ;;
    clang)
      DASHCONFIG=babycakes-config-clang.cmake
      source /Users/bloring/openmpi-1.6.4-clang.sh
      ;;
    *)
      echo "ERROR: bad config \$2=$2 is invalid."
      exit -1
esac
DASHROOT=/Users/bloring/visit/dashboards
#export LD_LIBRARY_PATH=$DASHROOT/visit-deps-2.8/visit/vtk/6.1.0/darwin/:$LD_LIBRARY_PATH
cd $DASHROOT
export DASHBOARD_TYPE=$1
EPOCH=`date +%s`
LOCKFILE=lock_$DASHBOARD_TYPE
if [[ -e $LOCKFILE ]]
then
    echo
    echo "ERROR: Found lockfile $LOCKFILE"
    echo "ERROR: Won't start another run while one is already running "
    echo
    exit -2
fi
touch $LOCKFILE
trap "rm $LOCKFILE; exit" SIGHUP SIGINT SIGTERM
ctest --timeout 120 -S $DASHROOT/$DASHCONFIG -O ./logs/$DASHBOARD_TYPE-$EPOCH.log -V
find $DASHROOT/logs -maxdepth 0 -name '*.log' -atime 2 -exec rm \{\} \;
rm $LOCKFILE
