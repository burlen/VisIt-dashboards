set(CTEST_PROJECT_NAME "VisIt")
#-----------------------------------------------------------------------------
# site specific config
set(CTEST_DASHBOARD_ROOT "/Users/bloring/visit/dashboards")
set(NERSC_USER loring)
set(CONFIG_SITE ${CTEST_DASHBOARD_ROOT}/visit-deps/babycakes.cmake)
set(CTEST_SITE "babycakes.lbl.gov")
set(CTEST_BUILD_NAME "MacOSX10.8.2-gcc4.2.1")
set(TEST_WARNINGS "-Wall -Wno-overloaded-virtual -Wno-unused-function -Wno-sign-compare -Wno-unused-variable -Wno-write-strings -Wno-parentheses -Wno-missing-braces")
set(ALWAYS_UPDATE ON)
set(INCREMENTAL_BUILD OFF)
#set($ENV{LC_MESSAGES} "en_US")
#-----------------------------------------------------------------------------
# general config
set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
set(CTEST_SOURCE_DIRECTORY "${CTEST_DASHBOARD_ROOT}/visit-src")
set(CTEST_BINARY_DIRECTORY "${CTEST_DASHBOARD_ROOT}/visit-build")
set(CTEST_TEST_ARGS PARALLEL_LEVEL 4)
set(CTEST_BUILD_FLAGS -j16)
set(CTEST_BUILD_CONFIGURATION Debug)
if (NOT CTEST_TEST_TIMEOUT)
    set(CTEST_TEST_TIMEOUT 120)
endif()
set(CTEST_SVN_COMMAND "/usr/bin/svn")
set(CTEST_UPDATE_COMMAND "${CTEST_SVN_COMMAND}")
#-----------------------------------------------------------------------------
# run the tests
if (NOT INCREMENTAL_BUILD)
    ctest_empty_binary_directory(${CTEST_BINARY_DIRECTORY})
    file(WRITE "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt"
"VISIT_CONFIG_SITE:STRING=${CONFIG_SITE}
CMAKE_BUILD_TYPE=Debug
BUILD_TESTING=ON
CMAKE_CXX_FLAGS=${TEST_WARNINGS}")
endif()
ctest_start("Experimental")
set(numUpdated 0)
ctest_update(SOURCE "${CTEST_SOURCE_DIRECTORY}" RETURN_VALUE numUpdated)
if (ALWAYS_UPDATE OR (numUpdated GREATER 0))
    message(STATUS "${numUpdated} files changed in the source tree")
    ctest_configure()
    ctest_read_custom_files("${CTEST_BINARY_DIRECTORY}")
    ctest_build()
    ctest_test()
    ctest_submit()
elseif (numUpdated LESS 0)
    message(STATUS "ERROR failed to update the sources")
else()
    message(STATUS "No files changed since the last dashboard run.")
endif()
