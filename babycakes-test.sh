#!/bin/bash
source /Users/bloring/openmpi-1.6.4.sh
ctest -S /Users/bloring/visit/dashboards/babycakes-config.cmake -O babycakes-test.log -V
