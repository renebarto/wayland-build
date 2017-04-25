# - Try to find LibXext
# Once done this will define
#  LIBXEXT_FOUND - System has LibXext
#  LIBXEXT_INCLUDE_DIR - The LibXext include directories
#  LIBXEXT_LIBRARIES - The libraries needed to use LibXext
#  LIBXEXT_DEFINITIONS - Compiler switches required for using LibXext

find_package(PkgConfig)
pkg_check_modules(PC_LIBXEXT QUIET xext)
set(LIBXEXT_DEFINITIONS ${PC_LIBXEXT_CFLAGS_OTHER})

if(PC_LIBXEXT_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "libxext        : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_LIBXEXT_VERSION}")
message(STATUS "  cflags       : ${PC_LIBXEXT_CFLAGS}")
message(STATUS "  cflags other : ${PC_LIBXEXT_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_LIBXEXT_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_LIBXEXT_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_LIBXEXT_LIBRARIES}")

find_path(LIBXEXT_INCLUDE_DIRS X11/extensions/Xext.h
        HINTS ${PC_LIBXEXT_INCLUDEDIR} ${PC_LIBXEXT_INCLUDE_DIRS})

find_library(LIBXEXT_LIBRARY NAMES Xext
        HINTS ${PC_LIBXEXT_LIBDIR} ${PC_LIBXEXT_LIBRARY_DIRS})

set(LIBXEXT_LIBRARIES ${LIBXEXT_LIBRARY} )
set(LIBXEXT_INCLUDE_DIR ${LIBXEXT_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set LIBXEXT_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(LIBXEXT DEFAULT_MSG
        LIBXEXT_LIBRARY LIBXEXT_INCLUDE_DIR)

if (LIBXEXT_FOUND)
    if(LIBXEXT_REQUIRED_VERSION)
        if (NOT "${LIBXEXT_REQUIRED_VERSION}" STREQUAL "${PC_LIBXEXT_VERSION}")
            message(WARNING "Incorrect version, please install libxext-${LIBXEXT_REQUIRED_VERSION}")
            unset(LIBXEXT_FOUND)
        endif()
    else()
        message(STATUS "Found libxext")
    endif()
else()
    message(WARNING "Could not find libxext, please install: sudo apt-get install libxext-dev")
endif()

mark_as_advanced(LIBXEXT_INCLUDE_DIR LIBXEXT_LIBRARY)
