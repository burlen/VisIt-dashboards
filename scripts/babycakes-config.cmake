set(CTEST_SITE "babycakes.lbl.gov")
set(CTEST_BUILD_NAME "MacOSX10.8.2-gcc4.2.1")
set(CTEST_DASHBOARD_ROOT "/Users/bloring/visit/dashboards")
set(CONFIG_SITE ${CTEST_DASHBOARD_ROOT}/visit-deps-all/babycakes-deps-all.cmake)
set(TEST_WARNINGS "-Wall -Wno-overloaded-virtual -Wno-unused-function -Wno-sign-compare -Wno-unused-variable -Wno-write-strings -Wno-parentheses -Wno-missing-braces")
set(INITIAL_CACHE
"VISIT_CONFIG_SITE:STRING=${CONFIG_SITE}
BUILD_TESTING=ON
CMAKE_CXX_FLAGS=${TEST_WARNINGS}")
set(CTEST_BUILD_CONFIGURATION Debug)
set(CTEST_SVN_COMMAND "/usr/bin/svn")
set(CTEST_TEST_ARGS PARALLEL_LEVEL 1)
set(CTEST_BUILD_FLAGS -j16)
set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
#set(ALWAYS_UPDATE ON)
#set(INCREMENTAL_BUILD OFF)
include("${CTEST_DASHBOARD_ROOT}/visit-dashboard.cmake")
