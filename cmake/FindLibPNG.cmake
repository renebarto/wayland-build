# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#.rst:
# FindLibPNG
# -------
#
# Find libpng, the official reference library for the LIBPNG image format.
#
# Imported targets
# ^^^^^^^^^^^^^^^^
#
# This module defines the following :prop_tgt:`IMPORTED` target:
#
# ``LIBPNG::LIBPNG``
#   The libpng library, if found.
#
# Result variables
# ^^^^^^^^^^^^^^^^
#
# This module will set the following variables in your project:
#
# ``LIBPNG_INCLUDE_DIRS``
#   where to find png.h, etc.
# ``LIBPNG_LIBRARIES``
#   the libraries to link against to use LIBPNG.
# ``LIBPNG_DEFINITIONS``
#   You should add_definitons(${LIBPNG_DEFINITIONS}) before compiling code
#   that includes png library files.
# ``LIBPNG_FOUND``
#   If false, do not try to use LIBPNG.
# ``LIBPNG_VERSION_STRING``
#   the version of the LIBPNG library found (since CMake 2.8.8)
#
# Obsolete variables
# ^^^^^^^^^^^^^^^^^^
#
# The following variables may also be set, for backwards compatibility:
#
# ``LIBPNG_LIBRARY``
#   where to find the LIBPNG library.
# ``LIBPNG_INCLUDE_DIR``
#   where to find the LIBPNG headers (same as LIBPNG_INCLUDE_DIRS)
#
# Since LIBPNG depends on the ZLib compression library, none of the above
# will be defined unless ZLib can be found.

find_package(ZLIB QUIET)
if(NOT ZLIB_FOUND)
  message(WARNING "Could not find zlib.")
endif()

find_package(PkgConfig)
pkg_check_modules(PC_LIBPNG QUIET libpng)

if(PC_LIBPNG_FOUND)
  set(FOUND_TEXT "Found")
else()
  set(FOUND_TEXT "Not found")
endif()

message(STATUS "libpng         : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_LIBPNG_VERSION}")
message(STATUS "  cflags       : ${PC_LIBPNG_CFLAGS}")
message(STATUS "  cflags other : ${PC_LIBPNG_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_LIBPNG_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_LIBPNG_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_LIBPNG_LIBRARIES}")

find_library(LIBPNG_LIBRARIES NAMES png libpng HINTS ${PC_LIBPNG_LIBRARY_DIRS})
find_path(LIBPNG_INCLUDE_DIRS png.h HINTS ${PC_LIBPNG_INCLUDE_DIRS})

set(LIBPNG_VERSION ${PC_LIBPNG_VERSION})
string(REPLACE "." ";" VERSION_LIST "${PC_LIBPNG_VERSION}")

LIST(LENGTH VERSION_LIST n)
if (n EQUAL 3)
    list(GET VERSION_LIST 0 LIBPNG_VERSION_MAJOR)
    list(GET VERSION_LIST 1 LIBPNG_VERSION_MINOR)
    list(GET VERSION_LIST 2 LIBPNG_VERSION_MICRO)
else ()
    set(LIBPNG_VERSION "9999.9999.9999")
    set(LIBPNG_VERSION_MAJOR 9999)
    set(LIBPNG_VERSION_MINOR 9999)
    set(LIBPNG_VERSION_MICRO 9999)
    message(WARNING "Could not detect libpng version, assuming you have recent one")
endif ()

# This is compatible with libpng-version.h that exists in upstream
# but isn't in distribution (probably forgotten)
set(LIBPNG_DEFINITIONS ${PC_LIBPNG_CFLAGS_OTHER}
    -DLIBPNG_VERSION=\"${LIBPNG_VERSION}\"
    -DLIBPNG_VERSION_MAJOR=${LIBPNG_VERSION_MAJOR}
    -DLIBPNG_VERSION_MINOR=${LIBPNG_VERSION_MINOR}
    -DLIBPNG_VERSION_MICRO=${LIBPNG_VERSION_MICRO})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LIBPNG
                                  REQUIRED_VARS LIBPNG_LIBRARIES LIBPNG_INCLUDE_DIRS
                                  LIBPNG_VERSION)

set(LIBPNG_LIBRARY ${LIBPNG_LIBRARIES})
set(LIBPNG_INCLUDE_DIR ${LIBPNG_INCLUDE_DIRS})

if (LIBPNG_FOUND)
    if(LIBPNG_REQUIRED_VERSION)
        if (NOT "${LIBPNG_REQUIRED_VERSION}" STREQUAL "${PC_LIBPNG_VERSION}")
            message(WARNING "Incorrect version, please install libpng-${LIBPNG_REQUIRED_VERSION}")
            unset(LIBPNG_FOUND)
        endif()
    else()
        message(STATUS "Found libpng ${LIBPNG_VERSION}")
    endif()
else()
    message(WARNING "Could not find libpng, please install: sudo apt-get install libpng-dev")
endif()

mark_as_advanced(LIBPNG_INCLUDE_DIR LIBPNG_LIBRARY)
