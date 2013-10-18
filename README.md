VisIt-dashboards
================
A collection of scripts that configure and run VisIt regression tests.

Usage
-----
1. create a "root" directory where your dashboard will live
2. in the root directory create 3 subdirectories 
2. * root/visit-src
2. * root/visit-deps
2. * root/visit-build
3. copy the "visit" dir(where all the compiled libraries are) from a recent run of build_visit into root/visit-deps
4. modify the paths and options in *missm-config.cmake* 
5. modify the run environment and command line in *missm-test.sh*
6. setup a cron job to run the dashboard



