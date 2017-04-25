# - Try to find LibXdmcp
# Once done this will define
#  LIBXDMCP_FOUND - System has LibXdmcp
#  LIBXDMCP_INCLUDE_DIR - The LibXdmcp include directories
#  LIBXDMCP_LIBRARIES - The libraries needed to use LibXdmcp
#  LIBXDMCP_DEFINITIONS - Compiler switches required for using LibXdmcp

find_package(PkgConfig)
pkg_check_modules(PC_LIBXDMCP QUIET xdmcp)
set(LIBXDMCP_DEFINITIONS ${PC_LIBXDMCP_CFLAGS_OTHER})

if(PC_LIBXDMCP_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "libxdmcp         : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_LIBXDMCP_VERSION}")
message(STATUS "  cflags       : ${PC_LIBXDMCP_CFLAGS}")
message(STATUS "  cflags other : ${PC_LIBXDMCP_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_LIBXDMCP_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_LIBXDMCP_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_LIBXDMCP_LIBRARIES}")

find_path(LIBXDMCP_INCLUDE_DIRS X11/Xauth.h
        HINTS ${PC_LIBXDMCP_INCLUDEDIR} ${PC_LIBXDMCP_INCLUDE_DIRS})

find_library(LIBXDMCP_LIBRARY NAMES Xau
        HINTS ${PC_LIBXDMCP_LIBDIR} ${PC_LIBXDMCP_LIBRARY_DIRS})

set(LIBXDMCP_LIBRARIES ${LIBXDMCP_LIBRARY} )
set(LIBXDMCP_INCLUDE_DIR ${LIBXDMCP_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set LIBXDMCP_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(LIBXDMCP DEFAULT_MSG
        LIBXDMCP_LIBRARY LIBXDMCP_INCLUDE_DIR)

if (LIBXDMCP_FOUND)
    if(LIBXDMCP_REQUIRED_VERSION)
        if (NOT "${LIBXDMCP_REQUIRED_VERSION}" STREQUAL "${PC_LIBXDMCP_VERSION}")
            message(WARNING "Incorrect version, please install libxdmcp-${LIBXDMCP_REQUIRED_VERSION}")
            unset(LIBXDMCP_FOUND)
        endif()
    else()
        message(STATUS "Found libxdmcp")
    endif()
else()
    message(WARNING "Could not find libxdmcp, please install: sudo apt-get install libxdmcp-dev")
endif()

mark_as_advanced(LIBXDMCP_INCLUDE_DIR LIBXDMCP_LIBRARY)
