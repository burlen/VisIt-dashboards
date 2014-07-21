#!/bin/bash -l
if [[ $# != 1 ]]
then
    echo
    echo "ERROR: Usage"
    echo "$0 Experimental|Nightly|Continuous"
    echo
    exit -1
fi
module load mpich-3.0.3-R
module load cmake-2.8.10
module load qt-4.8.2
DASHROOT=/work2/visit-branch/dashboard/
cd $DASHROOT
export LD_LIBRARY_PATH=$DASHROOT/visit-deps-2.8/visit/vtk/6.1.0/x86_64/lib:$LD_LIBRARY_PATH
export DISPLAY=:0
export DASHBOARD_TYPE=$1
case "$1" in
    Continuous)
      CTESTFLAGS="-L serial"
      ;;
    Nightly)
      cd Nightly/src
      SVNREV=`date +%Y-%m-%d -d "2 days ago"`
      echo $SVNREV
      svn up -r {"$SVNREV 22:00:00"}
      cd ../..
      ;;
esac
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
ctest --timeout 120 -S /work2/visit-branch/dashboard/missm-config.cmake -O ./logs/$DASHBOARD_TYPE-$EPOCH.log -V $CTESTFLAGS
find /work2/visit-branch/dashboard/logs -maxdepth 0 -name '*.log' -atime 2 -exec rm \{\} \;
rm $LOCKFILE
