# - Try to find XKBCommon
# Once done, this will define
#
#   LIBXKBCOMMON_FOUND - System has XKBCommon
#   LIBXKBCOMMON_INCLUDE_DIR - The XKBCommon include directories
#   LIBXKBCOMMON_LIBRARY - The libraries needed to use XKBCommon
#   LIBXKBCOMMON_DEFINITIONS - Compiler switches required for using XKBCommon

find_package(PkgConfig)
pkg_check_modules(PC_LIBXKBCOMMON QUIET xkbcommon)
set(LIBXKBCOMMON_DEFINITIONS ${PC_LIBXKBCOMMON_CFLAGS_OTHER})

if(PC_LIBXKBCOMMON_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "libxkbcommon   : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_LIBXKBCOMMON_VERSION}")
message(STATUS "  cflags       : ${PC_LIBXKBCOMMON_CFLAGS}")
message(STATUS "  cflags other : ${PC_LIBXKBCOMMON_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_LIBXKBCOMMON_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_LIBXKBCOMMON_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_LIBXKBCOMMON_LIBRARIES}")

find_path(LIBXKBCOMMON_INCLUDE_DIR
    NAMES xkbcommon/xkbcommon.h
    HINTS ${PC_LIBXKBCOMMON_INCLUDE_DIR} ${PC_LIBXKBCOMMON_INCLUDE_DIRS}
    )

find_library(LIBXKBCOMMON_LIBRARY
    NAMES xkbcommon
    HINTS ${PC_LIBXKBCOMMON_LIBRARY} ${PC_LIBXKBCOMMON_LIBRARY_DIRS}
    )

set(LIBXKBCOMMON_LIBRARIES ${LIBXKBCOMMON_LIBRARY})
set(LIBXKBCOMMON_LIBRARY_DIRS ${LIBXKBCOMMON_LIBRARY_DIRS})
set(LIBXKBCOMMON_INCLUDE_DIRS ${LIBXKBCOMMON_INCLUDE_DIR})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LIBXKBCOMMON DEFAULT_MSG
    LIBXKBCOMMON_LIBRARY
    LIBXKBCOMMON_INCLUDE_DIR
    )

if(LIBXKBCOMMON_FOUND)
    if (LIBXKBCOMMON_REQUIRED_VERSION)
        if (NOT "${LIBXKBCOMMON_REQUIRED_VERSION}" STREQUAL "${PC_LIBXKBCOMMON_VERSION}")
            message(WARNING "Incorrect version, please install libxkbcommon-${LIBXKBCOMMON_REQUIRED_VERSION}")
            unset(LIBXKBCOMMON_FOUND)
        endif()
    else()
        message(STATUS "Found libxkbcommon")
    endif()
else()
    message(WARNING "Could not find libxkbcommon, please install: sudo apt-get install libxkbcommon-dev")
endif()

mark_as_advanced(LIBXKBCOMMON_LIBRARY LIBXKBCOMMON_INCLUDE_DIR)