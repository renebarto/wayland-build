# - Try to find LibFFI
# Once done this will define
#  ZLIB_FOUND - System has LibFFI
#  ZLIB_INCLUDE_DIR - The LibFFI include directories
#  ZLIB_LIBRARIES - The libraries needed to use LibFFI
#  ZLIB_DEFINITIONS - Compiler switches required for using LibFFI

find_package(PkgConfig)
pkg_check_modules(PC_ZLIB QUIET zlib)
set(ZLIB_DEFINITIONS ${PC_ZLIB_CFLAGS_OTHER})

if(PC_ZLIB_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "zlib           : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_ZLIB_VERSION}")
message(STATUS "  cflags       : ${PC_ZLIB_CFLAGS}")
message(STATUS "  cflags other : ${PC_ZLIB_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_ZLIB_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_ZLIB_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_ZLIB_LIBRARIES}")

find_path(ZLIB_INCLUDE_DIRS zlib.h
        HINTS ${PC_ZLIB_INCLUDEDIR} ${PC_ZLIB_INCLUDE_DIRS})

find_library(ZLIB_LIBRARY NAMES z
        HINTS ${PC_ZLIB_LIBDIR} ${PC_ZLIB_LIBRARY_DIRS})

set(ZLIB_LIBRARIES ${ZLIB_LIBRARY} )
set(ZLIB_INCLUDE_DIR ${ZLIB_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set ZLIB_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(ZLIB DEFAULT_MSG
        ZLIB_LIBRARY ZLIB_INCLUDE_DIR)

if (ZLIB_FOUND)
    if(ZLIB_REQUIRED_VERSION)
        if (NOT "${ZLIB_REQUIRED_VERSION}" STREQUAL "${PC_ZLIB_VERSION}")
            message(WARNING "Incorrect version, please install zlib1g-${ZLIB_REQUIRED_VERSION}")
            unset(ZLIB_FOUND)
        endif()
    else()
        message(STATUS "Found zlib")
    endif()
else()
    message(WARNING "Could not find zlib, please install: sudo apt-get install zlib1g-dev")
endif()

mark_as_advanced(ZLIB_INCLUDE_DIR ZLIB_LIBRARY)
