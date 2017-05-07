# - Try to find GPerf
# Once done this will define
#  GPERF_FOUND - System has GPerf

find_program(GPERF_EXECUTABLE NAMES gperf
        HINTS ${CMAKE_INSTALL_PREFIX}/bin)

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set GPERF_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(GPERF DEFAULT_MSG
    GPERF_EXECUTABLE)

if(GPERF_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "gperf          : ${FOUND_TEXT}")
message(STATUS "  executable   : ${GPERF_EXECUTABLE}")

if (GPERF_FOUND)
    if(GPERF_REQUIRED_VERSION)
        if (NOT "${GPERF_REQUIRED_VERSION}" STREQUAL "${PC_GPERF_VERSION}")
            message(WARNING "Incorrect version, please install gperf-${GPERF_REQUIRED_VERSION}")
            unset(GPERF_FOUND)
        endif()
    else()
        message(STATUS "Found gperf")
    endif()
else()
    message(WARNING "Could not find gperf, please install: sudo apt-get install gperf")
endif()

mark_as_advanced(GPERF_INCLUDE_DIR GPERF_LIBRARY)
