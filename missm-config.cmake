set(CTEST_PROJECT_NAME "VisIt")
set(NERSC_USER loring)
set(CTEST_DASHBOARD_ROOT "/work3/visit-branch/dashboard/")
set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
set(CTEST_SITE "missmarple.lbl.gov")
set(CTEST_BUILD_NAME "linux-x86_64_gcc-4.6-g")
set(CTEST_SOURCE_DIRECTORY "${CTEST_DASHBOARD_ROOT}/visit-src")
set(CTEST_BINARY_DIRECTORY "${CTEST_DASHBOARD_ROOT}/visit-build")
set(CTEST_TEST_ARGS PARALLEL_LEVEL 4)
set(CTEST_BUILD_FLAGS -j32)
set(CTEST_BUILD_CONFIGURATION Debug)
if (NOT CTEST_TEST_TIMEOUT)
  set(CTEST_TEST_TIMEOUT 120)
endif()
set(CTEST_SVN_COMMAND "/usr/bin/svn")
set(CTEST_SVV_CHECKOUT
  "${CTEST_SVN_COMMAND} co svn+ssh://${NERSC_USER}@portal-auth.nersc.gov/project/projectdirs/visit/svn/visit/trunk/src visit-src/")
set(CTEST_UPDATE_COMMAND "${CTEST_SVN_COMMAND}")
set(CTEST_CUSTOM_MAXIMUM_NUMBER_OF_WARNINGS 2048)
#set($ENV{LC_MESSAGES} "en_US")
ctest_empty_binary_directory(${CTEST_BINARY_DIRECTORY})
file(WRITE "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt"
"
VISIT_CONFIG_SITE:STRING=${CTEST_DASHBOARD_ROOT}/visit-deps/missmarple.cmake
BUILDNAME:STRING=linux-x86_64_gcc-4.6-g
SITE:STRING=missmarple.lbl.gov
CMAKE_BUILD_TYPE=Debug
CMAKE_CXX_FLAGS=-Wall
")
ctest_start("Experimental")
ctest_update(SOURCE ${CTEST_SOURCE_DIRECTORY})
ctest_configure()
ctest_build()
ctest_test()
ctest_submit()
