# VisIt-dashboards
A collection of scripts that drive VisIt CDash regression tests.

## Usage
Note: the followinig assumes bash shell.

1. Choose a dashboard type, *Nightly* or *Continuous*. The *Nightly* type will once per day, at some convinient time of your choosing, fetch updates, blow away its build dir, make a full build, and run the regresssions. The *Continuous* type will periodically check for updates and make and incremental build if any are found.
2. Create a "root" directory where your dashboard will live and in the root directory create the following subdirectories.

        mkdir -p root/visit-build-{Nightly,Continuous}
        mkdir -p root/visit-deps
        mkdir -p root/visit-logs

3. Make an initial checkout of the source tree for each. Not you might have to set your NERSC username.

        cd root
        svn co svn+ssh://portal-auth.nersc.gov/project/projectdirs/visit/svn/visit/trunk/src visit-src-Nightly/
        svn co svn+ssh://portal-auth.nersc.gov/project/projectdirs/visit/svn/visit/trunk/src visit-src-Nightly/


4. Copy VisIt's dependencies from a recent run of *build_visit/visit* "into *root/visit-deps*. I'm expecting that all the library folders(vtk,hdf5, etc) be at this level. Copy your site config there as well.

        cp -r /path/to/build-visit/visit/* visit-deps


5. Pull the dashbaord scripts:

        git init
        git remote add github git@github.com:burlen/VisIt-dashboards.git
        git pull github master


6. In the scripts directory make a copy of one of the existing pairs of files to *hostname-config.cmake* and *hostname-test.sh*. Modify the copies of these files to fit the paths of your system. Back in the root directory make symlinks to the new copies.
7. Setup a cron job to run the dashboard at a convinient time. For example use *crontab -e* and add one or both of the following.

         # Nightly
         0 6 * * * /path/to/root/hostname-test.sh Nightly

         # Continuous
         0,30 * * * * /path/to/root/hostname-test.sh Continuous

