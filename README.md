# VisIt-dashboards
A collection of scripts that drive VisIt CDash regression tests.

## Usage
The followinig guide assumes bash shell.

1. Choose a dashboard type, *Nightly* or *Continuous*. The *Nightly* type will once per day, at some convinient time of your choosing, fetch updates, blow away its build dir, make a full build, and run the regresssions. The *Continuous* type will periodically check for updates and make and incremental build if any are found.
2. Create a "root" directory where your dashboard will live and in the root directory create the following subdirectories.

        mkdir -p dashroot/{Nightly,Continuous}
        mkdir -p dashroot/visit-deps
        mkdir -p dashroot/logs

3. Make an initial checkout of the sources, tests and data. Note you might have to set your NERSC username. If you have both *Nightly* and *Continuous* dashboards you need a source treee for each.

        cd dashroot/{Nightly,Continuous}
        svn co svn+ssh://portal-auth.nersc.gov/project/projectdirs/visit/svn/visit/trunk/src
        svn co svn+ssh://portal-auth.nersc.gov/project/projectdirs/visit/svn/visit/trunk/data
        svn co svn+ssh://portal-auth.nersc.gov/project/projectdirs/visit/svn/visit/trunk/test


4. Build VisIt's dependencies.

        cd dashroot/visit-deps
        ../{Nightly,Continuous}/src/svn_bin/build_visit --console --vtk --python --system-qt --mesa --system-cmake --parallel --no-pyside --no-visit --arch x86_64 --makeflags -j8 --advio --boxlib --ccmio --cfitsio --cgns --fastbit --gdal --h5part --hdf5 --mxml --netcdf --silo --szip --xdmf --zlib

5. Install PIL with zlib support into VisIt's python.

        wget http://effbot.org/downloads/Imaging-1.1.7.tar.gz
        tar xzfv Imaging-1.1.7.tar.gz
        cd Imaging-1.1.7
        vim setup.py
        #ZLIB_ROOT = libinclude("dashroot/visit-deps/visit/zlib/1.2.7/x86_64/")
        ../visit/python/2.7.5/x86_64/bin/python setup.py build_ext -i
        ../visit/python/2.7.5/x86_64/bin/python setup.py install

6. Pull the dashbaord scripts:

        git init
        git remote add github git@github.com:burlen/VisIt-dashboards.git
        git pull github master


6. In the scripts directory make a copy of one of the existing pairs of files to *hostname-config.cmake* and *hostname-test.sh*. Modify the copies of these files to fit the paths of your system. Back in the root directory make symlinks to the new copies.
7. Setup a cron job to run the dashboard at a convinient time. For example use *crontab -e* and add one or both of the following.

         # Nightly
         0 6 * * * /path/to/root/hostname-test.sh Nightly

         # Continuous
         0,30 * * * * /path/to/root/hostname-test.sh Continuous

