# - Try to find LibXcursor
# Once done this will define
#  LIBXCURSOR_FOUND - System has LibXcursor
#  LIBXCURSOR_INCLUDE_DIR - The LibXcursor include directories
#  LIBXCURSOR_LIBRARIES - The libraries needed to use LibXcursor
#  LIBXCURSOR_DEFINITIONS - Compiler switches required for using LibXcursor

find_package(PkgConfig)
pkg_check_modules(PC_LIBXCURSOR QUIET xcursor)
set(LIBXCURSOR_DEFINITIONS ${PC_LIBXCURSOR_CFLAGS_OTHER})

if(PC_LIBXCURSOR_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "libxcursor     : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_LIBXCURSOR_VERSION}")
message(STATUS "  cflags       : ${PC_LIBXCURSOR_CFLAGS}")
message(STATUS "  cflags other : ${PC_LIBXCURSOR_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_LIBXCURSOR_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_LIBXCURSOR_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_LIBXCURSOR_LIBRARIES}")

find_path(LIBXCURSOR_INCLUDE_DIRS X11/Xcursor/Xcursor.h
        HINTS ${PC_LIBXCURSOR_INCLUDEDIR} ${PC_LIBXCURSOR_INCLUDE_DIRS})

find_library(LIBXCURSOR_LIBRARY NAMES Xcursor
        HINTS ${PC_LIBXCURSOR_LIBDIR} ${PC_LIBXCURSOR_LIBRARY_DIRS})

set(LIBXCURSOR_LIBRARIES ${LIBXCURSOR_LIBRARY} )
set(LIBXCURSOR_INCLUDE_DIR ${LIBXCURSOR_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set LIBXCURSOR_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(LIBXCURSOR DEFAULT_MSG
        LIBXCURSOR_LIBRARY LIBXCURSOR_INCLUDE_DIR)

if (LIBXCURSOR_FOUND)
    if(LIBXCURSOR_REQUIRED_VERSION)
        if (NOT "${LIBXCURSOR_REQUIRED_VERSION}" STREQUAL "${PC_LIBXCURSOR_VERSION}")
            message(WARNING "Incorrect version, please install libxcursor-${LIBXCURSOR_REQUIRED_VERSION}")
            unset(LIBXCURSOR_FOUND)
        endif()
    else()
        message(STATUS "Found libxcursor")
    endif()
else()
    message(WARNING "Could not find libxcursor, please install: sudo apt-get install libxcursor-dev")
endif()

mark_as_advanced(LIBXCURSOR_INCLUDE_DIR LIBXCURSOR_LIBRARY)
