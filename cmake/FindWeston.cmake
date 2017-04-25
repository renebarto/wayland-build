# - Try to find Weston
# Once done this will define
#  WESTON_FOUND - System has Weston
#  WESTON_INCLUDE_DIR - The Weston include directories
#  WESTON_LIBRARIES - The libraries needed to use Weston
#  WESTON_DEFINITIONS - Compiler switches required for using Weston

find_package(PkgConfig)
pkg_check_modules(PC_WESTON QUIET weston)
set(WESTON_DEFINITIONS ${PC_WESTON_CFLAGS_OTHER})

if(PC_WESTON_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "weston         : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_WESTON_VERSION}")
message(STATUS "  cflags       : ${PC_WESTON_CFLAGS}")
message(STATUS "  cflags other : ${PC_WESTON_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_WESTON_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_WESTON_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_WESTON_LIBRARIES}")

find_path(WESTON_INCLUDE_DIRS ffi.h
        HINTS ${PC_WESTON_INCLUDEDIR} ${PC_WESTON_INCLUDE_DIRS})

find_library(WESTON_LIBRARY NAMES ffi
        HINTS ${PC_WESTON_LIBDIR} ${PC_WESTON_LIBRARY_DIRS} )

set(WESTON_LIBRARIES ${WESTON_LIBRARY} )
set(WESTON_INCLUDE_DIR ${WESTON_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set WESTON_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(Weston DEFAULT_MSG
        WESTON_LIBRARY WESTON_INCLUDE_DIR)

if (WESTON_FOUND)
    if(WESTON_REQUIRED_VERSION)
        if (NOT "${WESTON_REQUIRED_VERSION}" STREQUAL "${PC_WESTON_VERSION}")
            message(WARNING "Incorrect version, please install weston-${WESTON_REQUIRED_VERSION}")
            unset(WESTON_FOUND)
        endif()
    else()
        message(STATUS "Found weston")
    endif()
else()
    message(WARNING "Could not find weston, please install: sudo apt-get install weston")
endif()

mark_as_advanced(WESTON_INCLUDE_DIR WESTON_LIBRARY)
