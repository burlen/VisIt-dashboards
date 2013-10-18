# VisIt-dashboards
A collection of scripts that configure and run VisIt regression tests.

## Basic Usage
1. create a "root" directory where your dashboard will live
2. in the root directory create 3 subdirectories 
2. * root/visit-src
2. * root/visit-deps
2. * root/visit-build
3. copy the "visit" dir(where all the compiled libraries are) from a recent run of build_visit into root/visit-deps
4. modify the paths and options in *missm-config.cmake*. Consider renaming the file to <hostname>-config.cmake. 
5. modify the run environment and command line in *missm-test.sh*. Consider renaming the file to <hostname>-test.sh. 
6. setup a cron job to run the dashboard


##Advanced Usage
To update the dashboard on new commits. Set up a cron job to fire on a regular interval(eg 30 min) and in *missm-test.sh* set:

```cmake
ALWAYS_UPDATE=OFF
INCREMENTAL_BUILD=ON
```
