# - Try to find LibXfixes
# Once done this will define
#  LIBXFIXES_FOUND - System has LibXfixes
#  LIBXFIXES_INCLUDE_DIR - The LibXfixes include directories
#  LIBXFIXES_LIBRARIES - The libraries needed to use LibXfixes
#  LIBXFIXES_DEFINITIONS - Compiler switches required for using LibXfixes

find_package(PkgConfig)
pkg_check_modules(PC_LIBXFIXES QUIET xfixes)
set(LIBXFIXES_DEFINITIONS ${PC_LIBXFIXES_CFLAGS_OTHER})

if(PC_LIBXFIXES_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "libxfixes      : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_LIBXFIXES_VERSION}")
message(STATUS "  cflags       : ${PC_LIBXFIXES_CFLAGS}")
message(STATUS "  cflags other : ${PC_LIBXFIXES_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_LIBXFIXES_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_LIBXFIXES_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_LIBXFIXES_LIBRARIES}")

find_path(LIBXFIXES_INCLUDE_DIRS X11/extensions/Xfixes.h
        HINTS ${PC_LIBXFIXES_INCLUDEDIR} ${PC_LIBXFIXES_INCLUDE_DIRS})

find_library(LIBXFIXES_LIBRARY NAMES Xfixes
        HINTS ${PC_LIBXFIXES_LIBDIR} ${PC_LIBXFIXES_LIBRARY_DIRS})

set(LIBXFIXES_LIBRARIES ${LIBXFIXES_LIBRARY} )
set(LIBXFIXES_INCLUDE_DIR ${LIBXFIXES_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set LIBXFIXES_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(LIBXFIXES DEFAULT_MSG
        LIBXFIXES_LIBRARY LIBXFIXES_INCLUDE_DIR)

if (LIBXFIXES_FOUND)
    if(LIBXFIXES_REQUIRED_VERSION)
        if (NOT "${LIBXFIXES_REQUIRED_VERSION}" STREQUAL "${PC_LIBXFIXES_VERSION}")
            message(WARNING "Incorrect version, please install libxfixes-${LIBXFIXES_REQUIRED_VERSION}")
            unset(LIBXFIXES_FOUND)
        endif()
    else()
        message(STATUS "Found libxfixes")
    endif()
else()
    message(WARNING "Could not find libxfixes, please install: sudo apt-get install libxfixes-dev")
endif()

mark_as_advanced(LIBXFIXES_INCLUDE_DIR LIBXFIXES_LIBRARY)
