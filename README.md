# VisIt-dashboards
A collection of scripts that drive VisIt CDash regression tests.

## Usage
Note: the followinig assumes bash shell.

1. Choose a dashboard type, *Nightly* or *Continuous*. The *Nightly* type will once per day, at some convinient time of your choosing, fetch updates, blow away its build dir, make a full build, and run the regresssions. The *Continuous* type will periodically check for updates and make and incremental build if any are found.
2. Create a "root" directory where your dashboard will live and in the root directory create the following subdirectories.

        ```bash
        mkdir -p root/visit-build-{Nightly,Continuous}
        mkdir -p root/visit-deps
        ```

3. Make an initial checkout of the source tree for each. Not you might have to set your NERSC username.

        ```bash
        cd root
        svn co svn+ssh://portal-auth.nersc.gov/project/projectdirs/visit/svn/visit/trunk/src visit-src-Nightly/
        svn co svn+ssh://portal-auth.nersc.gov/project/projectdirs/visit/svn/visit/trunk/src visit-src-Nightly/
        ```


4. Copy VisIt's dependencies from a recent run of *build_visit/visit* "into *root/visit-deps*. I'm expecting that all the library folders(vtk,hdf5, etc) be at this level. Copy your site config there as well.

        ```bash
        cp -r /path/to/build-visit/visit/* visit-deps
        ```

5. Pull the dashbaord scripts:

        ```bash
        git init
        git remote add github git@github.com:burlen/VisIt-dashboards.git
        git pull github master```

6. In the scripts directory make a copy of one of the existing pairs fo files, *hostname-config.cmake* and *hostname-test.sh*. Back in the root directory make symlinks to the new copies. Modify the copies of these files to fit the paths of your system.
7. Setup a cron job to run the dashboard at a convinient time. For example

         ```
         # VisIt daily dashboard for missm
         0 6 * * * /work3/visit-branch/dashboard/missm-test.sh Nightly
         ```
