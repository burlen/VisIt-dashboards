# VisIt-dashboards
A collection of scripts that configure and run VisIt regression tests.

## Basic Usage
1. Create a "root" directory where your dashboard will live and in the root directory create the following 3 subdirectories
    * root/visit-src
    * root/visit-deps
    * root/visit-build
3. Make an initial checkout of the source tree
    * ````svn co svn+ssh://loring@portal-auth.nersc.gov/project/projectdirs/visit/svn/visit/trunk/src visit-src/````
4. Copy dependencies from *build_visit* "visit" dir(where all the compiled libraries are) into *root/visit-deps*
5. Copy your config site file into *root/visit-deps*
5. Make a copy of *missm-config.cmake* to *[hostname]-config.cmake* and modify the paths to match the paths and config site used above.
6. Make a copy of *missm-test.sh* to *[hostname]-test.sh* and modify the command line and run environment as needed. For example you may need to load MPI modules and so on.
7. Setup a cron job to run the dashboard at a convinient time.
    * ```# VisIt daily dashboard for missm
0 6 * * * /work3/visit-branch/dashboard/missm-test.sh```


##Advanced Usage
To update the dashboard on new commits. Set up a cron job to fire on a regular interval(eg 30 min) and in *[hostname]-test.sh* set:

```cmake
ALWAYS_UPDATE=OFF
INCREMENTAL_BUILD=ON
```
