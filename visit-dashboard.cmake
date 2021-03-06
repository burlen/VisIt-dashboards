#-----------------------------------------------------------------------------
# general config
set(CTEST_PROJECT_NAME "VisIt")
set(CTEST_NOTES_FILES ${CONFIG_SITE})
set(DASHBOARD_TYPE $ENV{DASHBOARD_TYPE})
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
    ctest_submit(PARTS Update Configure Build Notes RETRY_DELAY 15 RETRY_COUNT 10)
    ctest_test()
    ctest_submit(PARTS Test RETRY_DELAY 15 RETRY_COUNT 10)
endif()
