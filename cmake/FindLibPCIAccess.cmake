# - Try to find LIBPCIACCESS
# Once done this will define
#  LIBPCIACCESS_FOUND - System has LIBPCIACCESS
#  LIBPCIACCESS_INCLUDE_DIR - The LIBPCIACCESS include directories
#  LIBPCIACCESS_LIBRARIES - The libraries needed to use LIBPCIACCESS
#  LIBPCIACCESS_DEFINITIONS - Compiler switches required for using LIBPCIACCESS

find_package(PkgConfig)
pkg_check_modules(PC_LIBPCIACCESS QUIET pciaccess)
set(LIBPCIACCESS_DEFINITIONS ${PC_LIBPCIACCESS_CFLAGS_OTHER})

if(PC_LIBPCIACCESS_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "pciaccess      : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_LIBPCIACCESS_VERSION}")
message(STATUS "  cflags       : ${PC_LIBPCIACCESS_CFLAGS}")
message(STATUS "  cflags other : ${PC_LIBPCIACCESS_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_LIBPCIACCESS_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_LIBPCIACCESS_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_LIBPCIACCESS_LIBRARIES}")

find_path(LIBPCIACCESS_INCLUDE_DIRS pciaccess.h
        HINTS ${PC_LIBPCIACCESS_INCLUDEDIR} ${PC_LIBPCIACCESS_INCLUDE_DIRS})

find_library(LIBPCIACCESS_LIBRARY NAMES pciaccess
        HINTS ${PC_LIBPCIACCESS_LIBDIR} ${PC_LIBPCIACCESS_LIBRARY_DIRS} )

set(LIBPCIACCESS_LIBRARIES ${LIBPCIACCESS_LIBRARY} )
set(LIBPCIACCESS_INCLUDE_DIR ${LIBPCIACCESS_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set LIBPCIACCESS_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(LIBPCIACCESS DEFAULT_MSG
        LIBPCIACCESS_LIBRARY LIBPCIACCESS_INCLUDE_DIR)

if (LIBPCIACCESS_FOUND)
    if(LIBPCIACCESS_REQUIRED_VERSION)
        if (NOT "${LIBPCIACCESS_REQUIRED_VERSION}" STREQUAL "${PC_LIBPCIACCESS_VERSION}")
            message(WARNING "Incorrect version, please install libpciaccess-${LIBPCIACCESS_REQUIRED_VERSION}")
            unset(LIBPCIACCESS_FOUND)
        endif()
    else()
        message(STATUS "Found libpciaccess")
    endif()
else()
    message(WARNING "Could not find libpciaccess, please install: sudo apt-get install libpciaccess-dev")
endif()

mark_as_advanced(LIBPCIACCESS_INCLUDE_DIR LIBPCIACCESS_LIBRARY)
