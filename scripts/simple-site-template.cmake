#-----------------------------------------------------------------------------
# site-specific config
set(CTEST_SITE "host-name.lab.gov")
set(CTEST_BUILD_NAME "OS-Compiler-GPU")
set(CTEST_DASHBOARD_ROOT "/work/dashboards/visit")

# your visit configuration options go here
set(CONFIG_SITE ${CTEST_DASHBOARD_ROOT}/visit-deps/host-name.lab.gov)
set(TEST_WARNINGS "-Wall -Wno-unused-function -Wno-sign-compare -Wno-unused-variable -Wno-write-strings -Wno-parentheses -Wno-unused-but-set-variable -Wno-missing-braces -Wno-reorder -Wno-unused-result")
set(INITIAL_CACHE
"VISIT_CONFIG_SITE:STRING=${CONFIG_SITE}
BUILD_TESTING=ON
CMAKE_CXX_FLAGS=${TEST_WARNINGS}")

set(CTEST_SVN_COMMAND "/usr/bin/svn")
set(CTEST_BUILD_CONFIGURATION Debug)

set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
set(CTEST_BUILD_FLAGS -j8)

# choose Nightly or Contuinuous
set(DASHBOARD_TYPE "Nightly")

# use the following to force continuous dashbaords
#set(ALWAYS_UPDATE ON) # run even if no files changed
#set(INCREMENTAL_BUILD OFF) # start clean, rm the build

# when not set the result show up on the web as experimental
# don't set this until everything's working well.
#set(DASHBOARD_RELIABLE TRUE)

#-----------------------------------------------------------------------------
# general config should not need to change anything below
set(CTEST_PROJECT_NAME "VisIt")
set(CTEST_NOTES_FILES ${CONFIG_SITE})
if (NOT DEFINED ALWAYS_UPDATE)
    if (DASHBOARD_TYPE STREQUAL "Continuous")
        set(ALWAYS_UPDATE OFF)
    else()
        set(ALWAYS_UPDATE ON)
    endif()
endif()
if (NOT DEFINED INCREMENTAL_BUILD)
    if (DASHBOARD_TYPE STREQUAL "Continuous")
        set(INCREMENTAL_BUILD ON)
    else()
        set(INCREMENTAL_BUILD OFF)
    endif()
endif()
if (NOT DEFINED DASHBOARD_RELIABLE)
    set(DASHBOARD_TRACK "Experimental")
else()
    if (NOT DEFINED DASHBOARD_TRACK)
        set(DASHBOARD_TRACK ${DASHBOARD_TYPE})
    endif()
endif()
set(CTEST_SOURCE_DIRECTORY "${CTEST_DASHBOARD_ROOT}/${DASHBOARD_TYPE}/src")
set(VISIT_DATA_DIRECTORY "${CTEST_DASHBOARD_ROOT}/${DASHBOARD_TYPE}/data")
set(VISIT_TEST_DIRECTORY "${CTEST_DASHBOARD_ROOT}/${DASHBOARD_TYPE}/test")
set(CTEST_BINARY_DIRECTORY "${CTEST_DASHBOARD_ROOT}/${DASHBOARD_TYPE}/build")
if (NOT CTEST_TEST_TIMEOUT)
    set(CTEST_TEST_TIMEOUT 120)
endif()
set(CTEST_UPDATE_COMMAND "${CTEST_SVN_COMMAND}")
set(CTEST_TEST_ARGS PARALLEL_LEVEL 1)
#-----------------------------------------------------------------------------
# run the tests
if (NOT INCREMENTAL_BUILD)
    ctest_empty_binary_directory(${CTEST_BINARY_DIRECTORY})
    file(WRITE "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt"
        ${INITIAL_CACHE})
endif()
set(nSrcUpdated 0)
set(nDataUpdated 0)
set(nTestUpdated 0)
set(nUpdated 0)
ctest_start("${DASHBOARD_TRACK}")
ctest_update(SOURCE "${VISIT_DATA_DIRECTORY}" RETURN_VALUE nDataUpdated)
ctest_update(SOURCE "${VISIT_TEST_DIRECTORY}" RETURN_VALUE nTestUpdated)
ctest_update(SOURCE "${CTEST_SOURCE_DIRECTORY}" RETURN_VALUE nSrcUpdated)
math(EXPR nUpdated "${nSrcUpdated}+${nDataUpdated}+${nTestUpdated}")
if (ALWAYS_UPDATE OR (nUpdated GREATER 0))
    ctest_configure()
    ctest_read_custom_files("${CTEST_BINARY_DIRECTORY}")
    ctest_build()
    ctest_test()
    ctest_submit(RETRY_DELAY 15 RETRY_COUNT 10)
endif()
