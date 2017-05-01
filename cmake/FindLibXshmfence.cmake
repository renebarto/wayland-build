# - Try to find LibXshmfence
# Once done this will define
#  LIBXSHMFENCE_FOUND - System has LibXshmfence
#  LIBXSHMFENCE_INCLUDE_DIR - The LibXshmfence include directories
#  LIBXSHMFENCE_LIBRARIES - The libraries needed to use LibXshmfence
#  LIBXSHMFENCE_DEFINITIONS - Compiler switches required for using LibXshmfence

find_package(PkgConfig)
pkg_check_modules(PC_LIBXSHMFENCE QUIET xshmfence)
set(LIBXSHMFENCE_DEFINITIONS ${PC_LIBXSHMFENCE_CFLAGS_OTHER})

if(PC_LIBXSHMFENCE_FOUND)
    set(FOUND_TEXT "Found")
else()
    set(FOUND_TEXT "Not found")
endif()

message(STATUS "libxshmfence   : ${FOUND_TEXT}")
message(STATUS "  version      : ${PC_LIBXSHMFENCE_VERSION}")
message(STATUS "  cflags       : ${PC_LIBXSHMFENCE_CFLAGS}")
message(STATUS "  cflags other : ${PC_LIBXSHMFENCE_CFLAGS_OTHER}")
message(STATUS "  include dirs : ${PC_LIBXSHMFENCE_INCLUDE_DIRS}")
message(STATUS "  lib dirs     : ${PC_LIBXSHMFENCE_LIBRARY_DIRS}")
message(STATUS "  libs         : ${PC_LIBXSHMFENCE_LIBRARIES}")

find_path(LIBXSHMFENCE_INCLUDE_DIRS X11/xshmfence.h
        HINTS ${PC_LIBXSHMFENCE_INCLUDEDIR} ${PC_LIBXSHMFENCE_INCLUDE_DIRS})

find_library(LIBXSHMFENCE_LIBRARY NAMES xshmfence
        HINTS ${PC_LIBXSHMFENCE_LIBDIR} ${PC_LIBXSHMFENCE_LIBRARY_DIRS})

set(LIBXSHMFENCE_LIBRARIES ${LIBXSHMFENCE_LIBRARY} )
set(LIBXSHMFENCE_INCLUDE_DIR ${LIBXSHMFENCE_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIET and REQUIRED arguments and set LIBXSHMFENCE_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(LIBXSHMFENCE DEFAULT_MSG
        LIBXSHMFENCE_LIBRARY LIBXSHMFENCE_INCLUDE_DIR)

if (LIBXSHMFENCE_FOUND)
    if(LIBXSHMFENCE_REQUIRED_VERSION)
        if (NOT "${LIBXSHMFENCE_REQUIRED_VERSION}" STREQUAL "${PC_LIBXSHMFENCE_VERSION}")
            message(WARNING "Incorrect version, please install libxshmfence-${LIBXSHMFENCE_REQUIRED_VERSION}")
            unset(LIBXSHMFENCE_FOUND)
        endif()
    else()
        message(STATUS "Found libxshmfence")
    endif()
else()
    message(WARNING "Could not find libxshmfence, please install: sudo apt-get install libxshmfence-dev")
endif()

mark_as_advanced(LIBXSHMFENCE_INCLUDE_DIR LIBXSHMFENCE_LIBRARY)
