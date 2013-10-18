# VisIt-dashboards
A collection of scripts that configure and run VisIt regression tests.

## Basic Usage
1. create a "root" directory where your dashboard will live
2. in the root directory create 3 subdirectories 
2. * root/visit-src
2. * root/visit-deps
2. * root/visit-build
3. copy the "visit" dir(where all the compiled libraries are) from a recent run of build_visit into root/visit-deps
4. Make a copy of *missm-config.cmake* to *[hostname]-config.cmake* and modify the paths to match your dashboard root.
5. Make a copy of *missm-test.sh* to *[hostname]-test.sh* and modify the command line and run environment as needed. For example you may need to load MPI modules and so on.
6. Setup a cron job to run the dashboard at a convinient time.


##Advanced Usage
To update the dashboard on new commits. Set up a cron job to fire on a regular interval(eg 30 min) and in *[hostname]-test.sh* set:

```cmake
ALWAYS_UPDATE=OFF
INCREMENTAL_BUILD=ON
```
