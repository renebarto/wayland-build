#.rst:
# FindPixman
# -------
#
# Find Pixman library
#
# Try to find Pixman library. The following values are defined
#
# ::
#
#   PIXMAN_FOUND         - True if Pixman is available
#   PIXMAN_INCLUDE_DIR   - Include directories for Pixman
#   PIXMAN_LIBRARY       - List of libraries for Pixman
#   PIXMAN_DEFINITIONS   - List of definitions for Pixman
#
#=============================================================================
# Copyright (c) 2015 Jari Vetoniemi
#
# Distributed under the OSI-approved BSD License (the "License");
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================

include(FeatureSummary)
set_package_properties(Pixman PROPERTIES
    URL "http://pixman.org/"
    DESCRIPTION "Low-level software library for pixel manipulation")

find_package(PkgConfig)
pkg_check_modules(PC_PIXMAN QUIET pixman-1)

if(PC_PIXMAN_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "pixman-1       : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_PIXMAN_VERSION}")
message(STATUS "  cflags       : ${PC_PIXMAN_CFLAGS}")
message(STATUS "  cflags other : ${PC_PIXMAN_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_PIXMAN_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_PIXMAN_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_PIXMAN_LIBRARIES}")

find_library(PIXMAN_LIBRARIES NAMES pixman-1 HINTS ${PC_PIXMAN_LIBRARY_DIRS})
find_path(PIXMAN_INCLUDE_DIRS NAMES pixman.h PATH_SUFFIXES pixman-1 HINTS ${PC_PIXMAN_INCLUDE_DIRS})

set(PIXMAN_DEFINITIONS ${PC_PIXMAN_CFLAGS_OTHER})
set(PIXMAN_INCLUDE_DIR ${PIXMAN_INCLUDE_DIRS})
set(PIXMAN_LIBRARY ${PIXMAN_LIBRARIES})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(PIXMAN DEFAULT_MSG PIXMAN_LIBRARY PIXMAN_INCLUDE_DIR)

if (PIXMAN_FOUND)
    if(PIXMAN_REQUIRED_VERSION)
        if (NOT "${PIXMAN_REQUIRED_VERSION}" STREQUAL "${PC_PIXMAN_VERSION}")
            message(WARNING "Incorrect version, please install pixman-1-${PIXMAN_REQUIRED_VERSION}")
            unset(PIXMAN_FOUND)
        endif()
    else()
        message(STATUS "Found pixman-1")
    endif()
else()
    message(WARNING "Could not find pixman-1, please install: sudo apt-get install libpixman-1-dev")
endif()

mark_as_advanced(PIXMAN_INCLUDE_DIR PIXMAN_LIBRARY PIXMAN_DEFINITIONS)