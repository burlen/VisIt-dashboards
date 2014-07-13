#!/bin/bash -l
if [[ $# != 2 ]]
then
    echo
    echo "ERROR: Usage"
    echo "$0 Experimental|Nightly|Continuous asan|basic"
    echo
    exit -1
fi
DASHROOT=/work/dashboards/visit
cd $DASHROOT
case "$1" in
    Nightly)
      cd Nightly/src
      SVNREV=`date +%Y-%m-%d -d "2 days ago"`
      echo $SVNREV
      svn up -r {"$SVNREV 22:00:00"}
      cd ../..
      ;;
esac
case "$2" in
    basic)
      DASHCONFIG=rocky-config.cmake
      ;;
    asan)
      DASHCONFIG=rocky-config-asan.cmake
      export ASAN_SYMBOLIZER_PATH=`which llvm-symbolizer`
      export ASAN_OPTIONS=symbolize=1
      ;;
    *)
      echo "ERROR: bad config \$2=$2 is invalid."
      exit -1
esac
export LD_LIBRARY_PATH=$DASHROOT/visit-deps-asan/visit/vtk/6.1.0/x86_64/lib:$LD_LIBRARY_PATH
export DISPLAY=:0
export DASHBOARD_TYPE=$1
module load mpich/3.1-rc1
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
ctest --timeout 120 -S ${DASHROOT}/${DASHCONFIG} -O ./logs/$DASHBOARD_TYPE-$EPOCH.log -V
find ${DASHROOT}/logs -maxdepth 0 -name '*.log' -atime 2 -exec rm \{\} \;
rm $LOCKFILE
