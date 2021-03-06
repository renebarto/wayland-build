# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#.rst:
# FindEXPAT
# ---------
#
# Find expat
#
# Find the native EXPAT headers and libraries.
#
# ::
#
#   EXPAT_INCLUDE_DIRS - where to find expat.h, etc.
#   EXPAT_LIBRARIES    - List of libraries when using expat.
#   EXPAT_FOUND        - True if expat found.

find_package(PkgConfig QUIET)

pkg_check_modules(PC_EXPAT QUIET expat)

if(PC_EXPAT_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "expat          : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_EXPAT_VERSION}")
message(STATUS "  cflags       : ${PC_EXPAT_CFLAGS}")
message(STATUS "  cflags other : ${PC_EXPAT_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_EXPAT_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_EXPAT_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_EXPAT_LIBRARIES}")

# Look for the header file.
find_path(EXPAT_INCLUDE_DIR NAMES expat.h HINTS ${PC_EXPAT_INCLUDE_DIRS})

# Look for the library.
find_library(EXPAT_LIBRARY NAMES expat libexpat HINTS ${PC_EXPAT_LIBRARY_DIRS})

if (EXPAT_INCLUDE_DIR AND EXISTS "${EXPAT_INCLUDE_DIR}/expat.h")
    file(STRINGS "${EXPAT_INCLUDE_DIR}/expat.h" expat_version_str
         REGEX "^#[\t ]*define[\t ]+XML_(MAJOR|MINOR|MICRO)_VERSION[\t ]+[0-9]+$")

    unset(EXPAT_VERSION_STRING)
    foreach(VPART MAJOR MINOR MICRO)
        foreach(VLINE ${expat_version_str})
            if(VLINE MATCHES "^#[\t ]*define[\t ]+XML_${VPART}_VERSION[\t ]+([0-9]+)$")
                set(EXPAT_VERSION_PART "${CMAKE_MATCH_1}")
                if(EXPAT_VERSION_STRING)
                    string(APPEND EXPAT_VERSION_STRING ".${EXPAT_VERSION_PART}")
                else()
                    set(EXPAT_VERSION_STRING "${EXPAT_VERSION_PART}")
                endif()
            endif()
        endforeach()
    endforeach()
endif ()

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set EXPAT_FOUND to TRUE if
# all listed variables are TRUE
FIND_PACKAGE_HANDLE_STANDARD_ARGS(EXPAT
                                  REQUIRED_VARS EXPAT_LIBRARY EXPAT_INCLUDE_DIR
                                  VERSION_VAR EXPAT_VERSION_STRING)

# Copy the results to the output variables.
if(EXPAT_FOUND)
    if(EXPAT_REQUIRED_VERSION)
        if (NOT "${EXPAT_REQUIRED_VERSION}" STREQUAL "${PC_EXPAT_VERSION}")
            message(WARNING "Incorrect version, please install expat-${EXPAT_REQUIRED_VERSION}")
            unset(EXPAT_FOUND)
        endif()
    else()
        set(EXPAT_LIBRARIES ${EXPAT_LIBRARY})
        set(EXPAT_INCLUDE_DIRS ${EXPAT_INCLUDE_DIR})
        message(STATUS "Found expat")
    endif()
else()
    message(WARNING "Could not find expat, please install: sudo apt-get install libexpat1-dev")
endif()

mark_as_advanced(EXPAT_INCLUDE_DIR EXPAT_LIBRARY)
