set(CTEST_SITE "missmarple.lbl.gov")
set(CTEST_BUILD_NAME "Ubuntu12.04-gcc4.6.3")
set(CTEST_DASHBOARD_ROOT "/work2/visit-branch/dashboard/")
set(CONFIG_SITE ${CTEST_DASHBOARD_ROOT}/visit-deps-2.8/missmarple.cmake)
set(TEST_WARNINGS "-Wall")
set(INITIAL_CACHE
"VISIT_CONFIG_SITE:STRING=${CONFIG_SITE}
BUILD_TESTING=ON
VISIT_BUILD_ALL_PLUGINS=ON
VISIT_DATA_MANUAL_EXAMPLES=ON
CMAKE_CXX_FLAGS=${TEST_WARNINGS}") #TODO -- -D_GLIBCXX_DEBUG 
set(CTEST_BUILD_CONFIGURATION Debug)
set(CTEST_SVN_COMMAND "/usr/bin/svn")
set(CTEST_TEST_ARGS PARALLEL_LEVEL 1)
set(CTEST_BUILD_FLAGS -j32)
set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
#set(ALWAYS_UPDATE ON)
#set(INCREMENTAL_BUILD OFF)
set(DASHBOARD_RELIABLE TRUE)
include("${CTEST_DASHBOARD_ROOT}/visit-dashboard.cmake")
