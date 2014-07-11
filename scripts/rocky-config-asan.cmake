set(CTEST_SITE "rocky.lbl.gov")
set(CTEST_BUILD_NAME "Fedora19-gcc4.8.2-asan")
set(CTEST_DASHBOARD_ROOT "/work/dashboards/visit")
set(CONFIG_SITE ${CTEST_DASHBOARD_ROOT}/visit-deps-asan/rocky.dhcp-asan.cmake)
set(INITIAL_CACHE
"VISIT_CONFIG_SITE:STRING=${CONFIG_SITE}
BUILD_TESTING=ON
VISIT_BUILD_ALL_PLUGINS=ON
VISIT_DATA_MANUAL_EXAMPLES=ON
CMAKE_CXX_FLAGS=-g3 -fno-omit-frame-pointer -fsanitize=address -Wall -D_GLIBCXX_DEBUG
CMAKE_C_FLAGS=-g3 -fno-omit-frame-pointer -fsanitize=address -Wall")
set(CTEST_BUILD_CONFIGURATION Debug)
set(CTEST_SVN_COMMAND "/usr/bin/svn")
set(CTEST_TEST_ARGS PARALLEL_LEVEL 1)
set(CTEST_BUILD_FLAGS -j8)
set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
#set(ALWAYS_UPDATE ON)
#set(INCREMENTAL_BUILD OFF)
set(DASHBOARD_RELIABLE TRUE)
include("${CTEST_DASHBOARD_ROOT}/visit-dashboard.cmake")
