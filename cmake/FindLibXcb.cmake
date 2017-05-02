# - Try to find LibXcb
# Once done this will define
#  LIBXCB_FOUND - System has LibXcb
#  LIBXCB_INCLUDE_DIR - The LibXcb include directories
#  LIBXCB_LIBRARIES - The libraries needed to use LibXcb
#  LIBXCB_DEFINITIONS - Compiler switches required for using LibXcb

find_package(PkgConfig)
pkg_check_modules(PC_LIBXCB QUIET xcb)
set(LIBXCB_DEFINITIONS ${PC_LIBXCB_CFLAGS_OTHER})

if(PC_LIBXCB_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "libxcb         : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_LIBXCB_VERSION}")
message(STATUS "  cflags       : ${PC_LIBXCB_CFLAGS}")
message(STATUS "  cflags other : ${PC_LIBXCB_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_LIBXCB_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_LIBXCB_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_LIBXCB_LIBRARIES}")

find_path(LIBXCB_INCLUDE_DIRS xcb/xcb.h
        HINTS ${PC_LIBXCB_INCLUDEDIR} ${PC_LIBXCB_INCLUDE_DIRS})

find_library(LIBXCB_LIBRARY NAMES xcb
        HINTS ${PC_LIBXCB_LIBDIR} ${PC_LIBXCB_LIBRARY_DIRS})

set(LIBXCB_LIBRARIES ${LIBXCB_LIBRARY} )
set(LIBXCB_INCLUDE_DIR ${LIBXCB_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set LIBXCB_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(LIBXCB DEFAULT_MSG
        LIBXCB_LIBRARY LIBXCB_INCLUDE_DIR)

if (LIBXCB_FOUND)
    if(LIBXCB_REQUIRED_VERSION)
        if (NOT "${LIBXCB_REQUIRED_VERSION}" STREQUAL "${PC_LIBXCB_VERSION}")
            message(WARNING "Incorrect version, please install libffi-${LIBXCB_REQUIRED_VERSION}")
            unset(LIBXCB_FOUND)
        endif()
    else()
        message(STATUS "Found libxcb")
    endif()
else()
    message(WARNING "Could not find libxcb, please install: sudo apt-get install libxcb1-dev")
endif()

mark_as_advanced(LIBXCB_INCLUDE_DIR LIBXCB_LIBRARY)
